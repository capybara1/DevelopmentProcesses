#!/bin/bash

set -e

LOGFORMAT="%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

indent() { sed 's/^/  /'; }

cleanup() {
	echo "Cleanup"
	popd > /dev/null
	rm -rf $TMPDEMODIR1
	rm -rf $TMPDEMODIR2
}

TMPDEMODIR1=$(mktemp -d)
TMPDEMODIR2=$(mktemp -d)
pushd $TMPDEMODIR1 > /dev/null

trap cleanup EXIT

echo "Initialize"
git init |& indent
echo "* text eol=lf" > ".gitattributes"

echo "Remotes:"
git remote -v

echo "Current: $PWD"

echo "Commit on master"

echo "A" > demo.txt

git add demo.txt |& indent

git commit -m "Initial commit" |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

cd $TMPDEMODIR2
echo "Current: $PWD"

echo "Clone repository"

git clone $TMPDEMODIR1 . |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Remotes:"
git remote -v |& indent

echo "Create feature branch"

git checkout -b feature01 |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Commit on feature branch"

git checkout feature01 |& indent

echo "B" > demo2.txt

git add demo2.txt |& indent

git commit -m "Added second file" |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Push to remote:"
git push origin feature01 |& indent

cd $TMPDEMODIR1
echo "Current: $PWD"

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Merge feature branch into master"
git merge feature01 |& indent

cd $TMPDEMODIR2
echo "Current: $PWD"

echo "Fetch from remote"
git fetch origin |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent
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
[ "$(git remote -v)" ] || echo "none" | indent

echo -e "\x1B[36mCurrently at origin\x1B[m ($PWD)"

echo "Commit on master"

echo "A" > demo.txt

git add demo.txt |& indent

git commit -m "Initial commit" |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

cd $TMPDEMODIR2
echo -e "\x1B[35mCurrently at clone\x1B[m ($PWD)"

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

echo "Create pull-request (intended for communication):"
git request-pull HEAD~1 $TMPDEMODIR2 |& indent

cd $TMPDEMODIR1
echo -e "\x1B[36mCurrently at origin\x1B[m ($PWD)"

echo "Pull changes:"
git pull --rebase $TMPDEMODIR2 feature01 |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent
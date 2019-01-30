#!/bin/bash

set -e

ESC="%x1b"
TAB="%x09"
SPACE="%x20"
RED="$ESC[31m"
GREEN="$ESC[32m"
MAGENTA="$ESC[35m"
CYAN="$ESC[36m"
RESET="$ESC[m"
COMMIT_HASH="%h"
REF_NAME="%d"
SUBJECT="%s"
LOGFORMAT="$RED$COMMIT_HASH$TAB$GREEN$REF_NAME$RESET$SPACE$SUBJECT"

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

echo "Push to remote:"
git push origin feature01 |& indent

cd $TMPDEMODIR1
echo -e "\x1B[36mCurrently at origin\x1B[m ($PWD)"

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Merge feature branch into master"
git merge feature01 |& indent

cd $TMPDEMODIR2
echo -e "\x1B[35mCurrently at clone\x1B[m ($PWD)"

echo "Fetch from remote"
git fetch |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent
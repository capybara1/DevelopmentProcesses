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

echo -e "\x1B[36mCurrently at submodule\x1B[m ($PWD)"

echo "Initialize"
git init |& indent
echo "* text eol=lf" > ".gitattributes"

git add ".gitattributes" |& indent

echo "Commit on master"

echo "Sub" > demo.txt

git add demo.txt |& indent

git commit -m "Initial commit on submodule" |& indent

echo "Status:"
git status --short |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

cd $TMPDEMODIR2
echo -e "\x1B[35mCurrently at supermodule\x1B[m ($PWD)"

echo "Initialize"
git init |& indent
echo "* text eol=lf" > ".gitattributes"

git add ".gitattributes" |& indent

git commit -m "Initial commit on supermodule" |& indent

echo "Add submodule"
git submodule add $TMPDEMODIR2 sub |& indent

echo "Status:"
git status --short |& indent

echo "Content of .gitmodules:"
cat ".gitmodules" |& indent

echo "Commit changes:"
git commit -m "Added submodule" |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

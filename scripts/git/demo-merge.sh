#!/bin/bash

set -e

ESC="%x1b"
TAB="%x09"
SPACE="%x20"
RED="$ESC[31m"
GREEN="$ESC[32m"
RESET="$ESC[m"
COMMIT_HASH="%h"
REF_NAME="%d"
SUBJECT="%s"
LOGFORMAT="$RED$COMMIT_HASH$TAB$GREEN$REF_NAME$RESET$SPACE$SUBJECT"

indent() { sed 's/^/  /'; }

cleanup() {
	echo "Cleanup"
	popd > /dev/null
	rm -rf $TMPDEMODIR
}

TMPDEMODIR=$(mktemp -d)
pushd $TMPDEMODIR > /dev/null

trap cleanup EXIT

echo "Initialize"

git init |& indent
echo "* text eol=lf" > ".gitattributes"

echo "First commit on master"

echo "A" > demo.txt

git add demo.txt |& indent

git commit -m "Initial commit" |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Second commit on master"

echo "B" > demo.txt

git add demo.txt |& indent

git commit -m "Changed first line" |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Create feature branch"

git branch feature01 |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Third commit on master"

echo "C" > demo.txt

git add demo.txt |& indent

git commit -m "Changed first line" |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Commit on feature branch"

git checkout feature01 |& indent

echo "A2" > demo2.txt

git add demo2.txt |& indent

git commit -m "Changed second line" |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Merge feature branch into master"
git checkout master |& indent
git merge feature01 |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent
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

git add ".gitattributes" |& indent

echo "Initial commit"

echo "A" > demo.txt

git add demo.txt |& indent

git commit -m "Initial commit" |& indent

echo "Apply lightweight tag"
git tag "v0.1"

echo "Next commit"

echo "B" > demo.txt

git add demo.txt |& indent

git commit -m "2nd commit" |& indent

echo "Apply annotated tag"
git tag -a "v0.2" -m "Version 0.2"

echo "List tags:"
git tag |& indent

echo "Inspect annotated tag"
git show "v0.2" |& indent

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

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

echo "Continue work"

echo "B" > demo.txt

git add demo.txt |& indent

echo "Status:"
git status --short |& indent

echo "Stash"
git stash |& indent

echo "Status:"
[ "$(git status --short)" ] || echo "none" | indent

echo "List stashed work":
git stash list |& indent

echo "Apply stash"
git stash apply |& indent

echo "Status:"
git status --short |& indent

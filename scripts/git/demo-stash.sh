#!/bin/bash

set -e

LOGFORMAT="%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

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

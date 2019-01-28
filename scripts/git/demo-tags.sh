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

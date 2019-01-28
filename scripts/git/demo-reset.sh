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

echo "First commit"

echo "A
B" > demo.txt

git add demo.txt |& indent

git commit -m "Initial commit" |& indent

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Commit (1st attempt)"

echo "A
B2" > demo.txt

git add demo.txt |& indent

git commit -m "Changed second line" |& indent

echo "Git graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Soft reset"

git reset HEAD~1 --soft |& indent # moves only HEAD to 1st parent

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Status:"
git status --short |& indent

echo "Reset staged files"

git reset |& indent

echo "Commit (2nd attempt)"

git add demo.txt |& indent

git commit -m "Changed second line" |& indent

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Mixed reset"

git reset HEAD~1 |& indent # moves HEAD to 1st parent and resets the staged files in the index. --mixed is the implicit default

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Commit (3rd attempt)"

git add demo.txt |& indent

git commit -m "Changed second line" |& indent

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Hard reset"

git reset HEAD~1 --hard |& indent # moves HEAD to 1st parent and resets the staged files in the index as well as the working directory

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Status:"
[ "$(git status --short)" ] || echo "none" | indent

echo "Show Reflog:"
git reflog |& indent

echo "Undo reset:"
git reset 'HEAD@{1}' --hard |& indent

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Status:"
[ "$(git status --short)" ] || echo "none" | indent
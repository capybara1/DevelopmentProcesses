#!/bin/bash

LOGFORMAT="%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

indent() { sed 's/^/  /'; }

echo "Initialize"

TMPDEMODIR=$(mktemp -d)
pushd $TMPDEMODIR > /dev/null

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

echo "Cleanup"
popd > /dev/null
rm -rf $TMPDEMODIR
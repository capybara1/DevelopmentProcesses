#!/bin/bash

echo "Initialize"

TMPDEMODIR=$(mktemp -d)
pushd $TMPDEMODIR

git init

echo "First commit"

echo "A
B" > demo.txt

git add demo.txt

git commit -m "Initial commit"

git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

echo "Second commit (1)"

echo "A
B2" > demo.txt

git add demo.txt

git commit -m "Changed second line"

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

echo "soft reset"

git reset HEAD~1 --soft # moves only HEAD to 1st parent

echo "Graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

echo "Status:"
git status --short

echo "Reset staged files"

git reset

echo "Status:"
git status --short

echo "Second commit (2nd attempt)"

git add demo.txt

git commit -m "Changed second line"

echo "Graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

echo "Mixed reset"

git reset HEAD~1 # moves HEAD to 1st parent and resets the staged files in the index. --mixed is the implicit default

echo "Graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

echo "Status:"
git status --short

echo "Second commit (3rd attempt)"

git add demo.txt

git commit -m "Changed second line"

echo "Graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

echo "Hard reset"

git reset HEAD~1 --hard # moves HEAD to 1st parent and resets the staged files in the index as well as the working directory

echo "Graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

echo "Status:"
git status --short

echo "Undo reset"

git reflog

git reset 'HEAD@{1}'

echo "Graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

git reset --hard

echo "Cleanup"

popd
rm -rf $TMPDEMODIR
unset TMPDEMODIR
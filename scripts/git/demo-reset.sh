#!/bin/bash

# initialize

TMPDEMODIR=$(mktemp -d)
pushd $TMPDEMODIR

git init

# first commit

echo "A
B" > demo.txt

git add demo.txt

git commit -m "Initial commit"

git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

# second commit (1)

echo "A
B2" > demo.txt

git add demo.txt

git commit -m "Changed second line"

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

# soft reset

git reset HEAD~1 --soft # moves only HEAD to 1st parent

echo "Graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

echo "Status:"
git status --short

# reset staged files

git reset

echo "Status:"
git status --short

# second commit (2)

git add demo.txt

git commit -m "Changed second line"

echo "Graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

# hard reset

git reset HEAD~1 # moves HEAD to 1st parent and resets the staged files. --mixed is the implicit default

echo "Graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

echo "Status:"
git status --short

# second commit (3)

git add demo.txt

git commit -m "Changed second line"

echo "Graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

# hard  reset

git reset HEAD~1 --hard # moves HEAD to 1st parent and resets the staged files as well as the working directory

echo "Graph:"
git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

echo "Status:"
git status --short

# cleanup

popd
rmdir -rf $TMPDEMODIR
unset TMPDEMODIR
#!/bin/bash

LOGFORMAT="%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"

indent() { sed 's/^/  /'; }

echo "Initialize"

TMPDEMODIR=$(mktemp -d)
pushd $TMPDEMODIR > /dev/null

git init | indent

echo "First commit on master"

echo "A" > demo.txt

git add demo.txt | indent

git commit -m "Initial commit" | indent

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT | indent

echo "Second commit on master"

echo "B" > demo.txt

git add demo.txt | indent

git commit -m "Changed first line" | indent

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT | indent

echo "Create feature branch"

git branch feature01 | indent

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT | indent

echo "Third commit on master"

echo "C" > demo.txt

git add demo.txt | indent

git commit -m "Changed first line" | indent

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT | indent

echo "Commit on feature branch"

git checkout feature01 | indent

echo "A2" > demo2.txt

git add demo2.txt | indent

git commit -m "Changed second line" | indent

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT | indent

echo "Rebase feature branch to tip of master"
git rebase master | indent

echo "Merge feature branch into master"
git checkout master | indent
git merge feature01 --ff-only | indent

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT | indent

echo "Cleanup"
popd > /dev/null
rm -rf $TMPDEMODIR
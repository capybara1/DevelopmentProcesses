#!/bin/bash

echo "Initialize"

LOGFORMAT=$LOGFORMAT
TMPDEMODIR=$(mktemp -d)
pushd $TMPDEMODIR

git init

echo "First commit on master"

echo "A" > demo.txt

git add demo.txt

git commit -m "Initial commit"

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT

echo "Second commit on master"

echo "B" > demo.txt

git add demo.txt

git commit -m "Changed first line"

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT

echo "Create feature branch"

git branch feature01

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT

echo "Third commit on master"

echo "C" > demo.txt

git add demo.txt

git commit -m "Changed first line"

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT

echo "Commit on feature branch"

git checkout feature01

echo "A2" > demo2.txt

git add demo2.txt

git commit -m "Changed second line"

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT

echo "Rebase feature branch to tip of master"
git rebase master

echo "Merge feature branch into master"
git checkout master
git merge feature01 --ff-only

echo "Git graph:"
git log --graph --full-history --all --color --pretty=format:$LOGFORMAT

echo "Cleanup"
popd
rm -rf $TMPDEMODIR
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

echo "First commit"

echo "A
B" > demo.txt

git add demo.txt |& indent

git commit -m "Initial commit" |& indent

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Commit (4th attempt with accidental commit of sensitive data)"

echo "Some confidential information" > passwords.txt

git add passwords.txt |& indent

git commit -m "Added passwords" |& indent

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Status:"
[ "$(git status --short)" ] || echo "none" | indent

echo "Remove file with sensitive data"

git filter-branch --force --prune-empty \
--index-filter "git rm --cached --ignore-unmatch passwords.txt" \
--tag-name-filter cat \
-- --all |& indent

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Remove backed up references"
git for-each-ref --format="%(refname)" refs/original/ \
| xargs -n 1 git update-ref -d

echo "Expire reflog an run GC"
git reflog expire --expire=now --all \
&& git gc --prune=now --aggressive |& indent

echo "Graph:"
{ git log --graph --full-history --all --color --pretty=format:$LOGFORMAT; echo; } |& indent

echo "Show Reflog:"
[ "$(git reflog)" ] || echo "empty" | indent

echo "Working directory:"
ls -A |& indent

echo "Status:"
[ "$(git status --short)" ] || echo "none" | indent
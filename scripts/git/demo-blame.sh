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

cat > demo.txt <<EOF
A
B
C
D
EOF

git add demo.txt |& indent

git commit -m "Initial commit" |& indent

echo "Next commit"

cat > demo.txt <<EOF
A
B2
C
D
E
EOF

git add demo.txt |& indent

git commit -m "2nd commit" |& indent

echo "Annotate code"

git blame demo.txt |& indent

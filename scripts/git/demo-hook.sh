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

echo "Add pre-commit hook"

cat > ./.git/hooks/pre-commit <<EOF
#!/bin/bash
exec 1>&2
echo -e "\x1B[31mDemo check failed\x1B[m"
exit 1
EOF

chmod +x ./.git/hooks/pre-commit

echo "Perform test commit"

echo "A" > demo.txt

git add demo.txt |& indent

git commit -m "Should fail" |& indent

echo "Graph:"
[ "$(git rev-list --all --count)" == "0" ] && echo "empty" | indent

echo "Status:"
git status --short |& indent
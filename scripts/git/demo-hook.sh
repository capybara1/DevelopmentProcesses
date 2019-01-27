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

echo "Add pre-commit hook"

echo "#!/bin/bash
exec 1>&2
echo -e \"\\x1B[31mDemo check failed\\x1B[m\"
exit 1" > ./.git/hooks/pre-commit

chmod +x ./.git/hooks/pre-commit

echo "Perform test commit"

echo "A" > demo.txt

git add demo.txt |& indent

git commit -m "Should fail" |& indent

echo "Graph:"
[ "$(git rev-list --all --count)" == "0" ] && echo "empty" | indent

echo "Status:"
git status --short |& indent
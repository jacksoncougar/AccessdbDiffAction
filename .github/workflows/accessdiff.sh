#!/bin/sh
echo "accessdiff.sh"
pwd
BEFORE="${2%.accdb}.xml"
AFTER="${1%.accdb}.xml"
ACCESSDIFF=".github/workflows/test.sh"

$ACCESSDIFF $1 > "$BEFORE"
$ACCESSDIFF $2 > "$AFTER"

cat "$BEFORE"
cat "$AFTER"

git diff --no-index  "$BEFORE" "$AFTER"

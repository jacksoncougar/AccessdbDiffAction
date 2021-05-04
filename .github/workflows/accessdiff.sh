#!/bin/sh
echo "accessdiff.sh"
BEFORE="${2%.accdb}.xml"
AFTER="${1%.accdb}.xml"
ACCESSDIFF="cat"
$ACCESSDIFF $1 > "$BEFORE"
$ACCESSDIFF $2 > "$AFTER"
git diff --no-ext-diff --no-index  "$BEFORE" "$AFTER"

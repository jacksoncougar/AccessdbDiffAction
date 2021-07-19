#!/bin/sh

BEFORE="${2%.accdb}-before.json"
AFTER="${2%.accdb}.json"
ACCESS_TO_JSON=".github/workflows/export-accdb-tables-to-json.sh"

echo "" >"$BEFORE"
$ACCESS_TO_JSON $2 "$AFTER"

cat $BEFORE
cat $AFTER

git diff --no-ext-diff --no-index $BEFORE $AFTER

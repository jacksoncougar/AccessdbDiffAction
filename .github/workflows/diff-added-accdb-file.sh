#!/bin/sh

BEFORE="${2%.accdb}-before.json"
AFTER="${2%.accdb}.json"
ACCESS_TO_JSON="${GITHUB_ACTION_PATH}/.github/workflows/export-accdb-tables-to-json.sh"

echo "" >"$BEFORE"
$ACCESS_TO_JSON $2 "$AFTER"

git diff --no-ext-diff --no-index $BEFORE $AFTER

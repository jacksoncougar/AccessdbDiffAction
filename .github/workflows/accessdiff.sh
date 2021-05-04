#!/bin/sh
BEFORE="${2%.accdb}.xml"
AFTER="${1%.accdb}.xml"
ACCESSDIFF=".github/workflows/test.sh"

$ACCESSDIFF $2 "$BEFORE"
$ACCESSDIFF $1 "$AFTER"

git diff --no-ext-diff --no-index  $BEFORE $AFTER

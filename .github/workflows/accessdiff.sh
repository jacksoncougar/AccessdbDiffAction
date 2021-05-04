#!/bin/sh
BEFORE="${2%.accdb}.xml"
AFTER="${1%.accdb}.xml"
ACCESSDIFF="C:\Users\jwiebe\source\repos\SolutionBuilder\SolutionBuilderUtililty\bin\Debug\netcoreapp3.1\SolutionBuilderUtililty.exe"
$ACCESSDIFF $1 > "$BEFORE"
$ACCESSDIFF $2 > "$AFTER"
git diff --no-ext-diff --no-index "$BEFORE" "$AFTER"

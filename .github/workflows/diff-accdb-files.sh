#!/bin/sh
HEAD=$1 #expects to be passed a valid commit HEAD as the first parameter.
BASE=$2

# gets the names of accdb files that have been modified in the given commit
# and then pipes that into a custom diff script.
echo "diff-modified-accdb-file.sh"
.github/workflows/list-accdb-files.sh $HEAD "M" |
	xargs -I{} \
		git difftool --extcmd=.github/workflows/diff-modified-accdb-file.sh "$BASE" {} --no-prompt

echo "diff-added-accdb-file.sh"
.github/workflows/list-accdb-files.sh $HEAD "A" |
	xargs -I{} \
		git difftool --extcmd=.github/workflows/diff-added-accdb-file.sh "$BASE" {} --no-prompt

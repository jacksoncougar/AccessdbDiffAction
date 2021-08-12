#!/bin/sh
HEAD=$1 #expects to be passed a valid commit HEAD as the first parameter.
BASE=$2

# gets the names of accdb files that have been modified in the given commit
# and then pipes that into a custom diff script.
${GITHUB_ACTION_PATH}/list-accdb-files.sh $HEAD "M" |
	xargs -I{} \
		git difftool --extcmd="${GITHUB_ACTION_PATH}/diff-modified-accdb-file.sh" "$BASE" {} --no-prompt

${GITHUB_ACTION_PATH}/list-accdb-files.sh $HEAD "A" |
	xargs -I{} \
		git difftool --extcmd="${GITHUB_ACTION_PATH}/diff-added-accdb-file.sh" "$BASE" {} --no-prompt

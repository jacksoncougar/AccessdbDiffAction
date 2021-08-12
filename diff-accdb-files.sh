#!/bin/sh
HEAD=$1 #expects to be passed a valid commit HEAD as the first parameter.
BASE=$2

# gets the names of accdb files that have been modified in the given commit
# and then pipes that into a custom diff script.

{
    $GITHUB_ACTION_PATH/list-accdb-files.sh $HEAD M | while read -r f ;
    do
        git difftool --extcmd="$GITHUB_ACTION_PATH/diff-modified-accdb-file.sh" "$BASE" "$f" --no-prompt \
        | jq -s --join-output --compact-output --arg filename "$f" --raw-input '. | { name: $filename, text: . }'
    done
    
    $GITHUB_ACTION_PATH/list-accdb-files.sh $HEAD A | while read -r f ;
    do
        git difftool --extcmd="$GITHUB_ACTION_PATH/diff-added-accdb-file.sh" "$BASE" "$f" --no-prompt \
        | jq -s --join-output --compact-output --arg filename "$f" --raw-input '. | { name: $filename, text: . }'
    done
} | jq --join-output --compact-output --slurp '. | { files: . }'
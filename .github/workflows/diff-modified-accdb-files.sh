#!/bin/sh
HASH=$1 #expects to be passed a valid commit hash as the first parameter.

# gets the names of accdb files that have been modified in the given commit 
# and then pipes that into a custom diff script.
.github/workflows/list-modified-accdb-files.sh $HASH \
| xargs -I{} \
  git difftool --extcmd=.github/workflows/diff-accdb-file.sh "$HASH~1" {} --no-prompt 


#!/bin/sh
HASH=$1 #expects to be passed a valid commit hash as the first parameter.

# gets the names of accdb files that have been modified in the given commit 
# and then pipes that into a custom diff script.
git diff-tree \
  --no-commit-id --name-only -r --diff-filter=M $HASH -- *.accdb \
| xargs -I{} \
  git difftool --extcmd=.github/workflows/diff-accdb-file.sh HEAD~1 {} --no-prompt 


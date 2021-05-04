#!/bin/sh
HASH=$1
echo "\`\`\`diff"
git diff-tree --no-commit-id --name-only -r $HASH | grep accdb | xargs -I{} git difftool --extcmd=.github/workflows/accessdiff.sh HEAD~1 {} --no-prompt 
echo "\`\`\`"

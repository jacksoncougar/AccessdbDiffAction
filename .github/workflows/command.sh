#!/bin/sh
echo "command.sh"
HASH=$1
RESULT=$(git diff-tree --no-commit-id --name-only -r $HASH | grep accdb | xargs -I{} git difftool --extcmd=.github/workflows/accessdiff.sh $HASH~1 {} --no-prompt)

if [ -n "$RESULT" ]; then echo "::error file=app.js,line=10,col=15::$RESULT"; fi
exit 0

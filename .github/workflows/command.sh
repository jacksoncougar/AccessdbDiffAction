#!/bin/sh
echo "command.sh"
HASH=$1
RESULT=$(git diff-tree --no-commit-id --name-only -r $HASH | grep accdb | xargs -I{} git difftool --extcmd=.github/workflows/accessdiff.sh $HASH~1 {} --no-prompt | sed ':a;N;$!ba;s/\n/%0A/g'  )
echo $(git diff-tree --no-commit-id --name-only -r $HASH )
echo $HASH
if [ -n "$RESULT" ]; then echo "::error file=data/test.accdb,line=1,col=1::$RESULT"; fi
exit 0 

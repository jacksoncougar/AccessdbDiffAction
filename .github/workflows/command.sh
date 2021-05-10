#!/bin/sh
echo "command.sh2"
HASH=$1
echo $(git diff-tree --no-commit-id --name-only -r $HASH )
echo $HASH
RESULT=$(git diff-tree --no-commit-id --name-only -r $HASH | grep accdb | xargs -I{} git difftool --extcmd=.github/workflows/accessdiff.sh HEAD^^ {} --no-prompt | sed ':a;N;$!ba;s/\n/%0A/g'  )
# RESULT@(git diff-tree --no-commit-id 
# --name-only -r cc16265449856e28755041116826a70127cf6ef1 | Select-String accdb) | %{git difftool --extcmd=.github/workflows/accessdiff.sh HEAD~1 $_ --no-prompt}

if [ -n "$RESULT" ]; then echo "::error file=data/SchemaSy.accdb,line=1,col=1::$RESULT"; fi

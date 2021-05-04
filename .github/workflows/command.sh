#!/bin/sh
echo "command.sh"
HASH=$1
RESULT=$(git diff-tree --no-commit-id --name-only -r $HASH)
echo "::error file=app.js,line=10,col=15::DIFF"
echo "$RESULT"
exit 0

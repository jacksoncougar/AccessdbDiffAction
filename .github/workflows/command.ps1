$ErrorView = "NormalView"
echo "command.sh2"
$HASH=$args[0]
echo $(git diff-tree --no-commit-id --name-only -r $HASH )
echo $HASH
# RESULT=$(git diff-tree --no-commit-id --name-only -r $HASH | grep accdb | xargs -I{} git difftool --extcmd=.github/workflows/accessdiff.sh $HASH~1 {} --no-prompt | sed ':a;N;$!ba;s/\n/%0A/g'  )
$RESULT=@(git diff-tree --no-commit-id --name-only -r $HASH | Select-String accdb) | %{@($_, $(git difftool --extcmd=.github/workflows/accessdiff.ps1 $HASH~1 $_ --no-prompt))}
if ($RESULT -eq $null) {
  echo "Nothing changed"
} else {
  echo "::error file=data/SchemaSy.accdb,line=1,col=1::$RESULT[0]";
}

exit 0 

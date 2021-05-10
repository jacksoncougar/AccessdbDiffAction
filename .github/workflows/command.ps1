$ErrorView = "NormalView"
$HASH=$args[0]
$RESULT=@(git diff-tree --no-commit-id --name-only -r $HASH) | where{$_ -like "*.accdb"} | %{git difftool --no-prompt --extcmd=.github/workflows/accessdiff.sh $HASH~1 $_ }

Write-Output $RESULT 
# if ($RESULT -eq $null) {
#   echo "Nothing changed"
# } else {
#   echo "::error file=data/SchemaSy.accdb,line=1,col=1::$RESULT[0]";
# }

exit 0 

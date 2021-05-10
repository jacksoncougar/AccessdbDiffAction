
$A = $args[0]
$B = $args[1]
$BEFORE=$args[0] -replace ".accdb", ".xml"
$AFTER=$args[1] -replace ".accdb", ".xml"
$ACCESSDIFF="$GITHUB_WORKSPACE/bin/SolutionCliTools"

Start-Process $ACCESSDIFF -ArgumentList $A -RedirectStandardOutput "$BEFORE" -NoNewWindow
Start-Process $ACCESSDIFF -ArgumentList $B -RedirectStandardOutput "$AFTER" -NoNewWindow
git diff --no-ext-diff --no-index  "$BEFORE" "$AFTER"

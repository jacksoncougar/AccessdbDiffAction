
$A = $args[0]
$B = $args[1]
$BEFORE=$args[0] -replace ".accdb", ".xml"
$AFTER=$args[1] -replace ".accdb", ".xml"
$ACCESSDIFF="$GITHUB_WORKSPACE/bin/SolutionCliTools"

& $ACCESSDIFF $A > "$BEFORE"
& $ACCESSDIFF $B  > "$AFTER"
& git diff --no-ext-diff --no-index  "$BEFORE" "$AFTER"

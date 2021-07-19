#!/bin/sh
HASH=$1 #expects to be passed a valid commit hash as the first parameter.
FILTER=$2

git diff-tree \
  --no-commit-id \
  --name-only \
  -r \
  --diff-filter="$FILTER" \
	$HASH \
  -- *.accdb

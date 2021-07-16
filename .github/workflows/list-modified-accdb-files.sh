#!/bin/sh
HASH=$1 #expects to be passed a valid commit hash as the first parameter.

git diff-tree \
  --no-commit-id \
  --name-only \
  -r \
  --diff-filter=M $HASH \
  -- *.accdb
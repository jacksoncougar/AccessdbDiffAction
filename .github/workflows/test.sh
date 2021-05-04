#!/bin/sh
echo $1
echo $2
{
  truncate -s 0 $2
  for table in $(mdb-tables $1)
  do
    mdb-export -d "###c3385512-7ade-4ff3-b718-3dceb8626abf###" $1 $table \
    | jq --unbuffered -M -R 'split("###c3385512-7ade-4ff3-b718-3dceb8626abf###")' \
    | jq --unbuffered -M --slurp .  \
    | jq --unbuffered -M -f ./.github/workflows/csv2json-helper.jq >> $2
  done
} > /dev/null

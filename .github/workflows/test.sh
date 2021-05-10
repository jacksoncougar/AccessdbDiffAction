#!/bin/sh

for table in $(mdb-tables data/SchemaSy.accdb)
do
  mdb-export -d "###c3385512-7ade-4ff3-b718-3dceb8626abf###" data/SchemaSy.accdb $table \
  | jq -R 'split("###c3385512-7ade-4ff3-b718-3dceb8626abf###")' \
  | jq --slurp .  \
  | jq -f ./.github/workflows/csv2json-helper.jq
done


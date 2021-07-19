#!/bin/sh
# Converts an accdb file into a json file

ACCDB_FILE=$1
DIFF_OUTPUT=$2

truncate --size 0 $DIFF_OUTPUT
for table in $(mdb-tables $ACCDB_FILE | tr " " "\n" | sort)
do
	mdb-export $ACCDB_FILE $table | csvtojson | jq --slurp ". | {"$table": .}" >> $DIFF_OUTPUT
done

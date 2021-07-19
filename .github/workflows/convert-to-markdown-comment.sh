#!/bin/sh

echo '```diff'
DONE=false
until $eof; do
	read line || eof=true
	echo $line
done
echo '```'

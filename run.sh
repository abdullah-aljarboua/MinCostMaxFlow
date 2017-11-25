#! /usr/bin/env bash

files=`ls data/`

for f in $files
do
	echo "Processing $f"
	echo "Processing $f" >> results.txt
	make FILE_NAME=data/$f run >> results.txt
done
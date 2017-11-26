#! /usr/bin/env bash

files=`ls data/`

for f in $files
do
	echo "Processing $f"
	make FILE_NAME=data/$f run >> algorithm_1_results.txt
done
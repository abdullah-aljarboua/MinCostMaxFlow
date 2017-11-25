#! bin/sh

files=`ls par/`

for f in $files
do
	echo "Processing $f"
	TARGET=`basename $f .param`
	./netgen par/$f > data/$TARGET
done
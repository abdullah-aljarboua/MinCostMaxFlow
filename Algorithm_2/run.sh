#! /usr/bin/env bash

files=`ls ../Data_Alg2/*.ini`

g++ -Wall -Wextra -std=c++11 -o a.out main.cpp
for f in $files
do
	echo "Processing $f"
	echo "Processing $f" >> results.txt
	./a.out ../Data_Alg2/$f >> results.txt
done
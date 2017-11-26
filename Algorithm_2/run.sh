#! /usr/bin/env bash

files=`ls ../Data_Alg2/*.ini`

g++ -Wall -Wextra -std=c++11 -o a.out main.cpp
for f in $files
do
	echo "Processing $f"
	./a.out ../Data_Alg2/$f >> algorithm_2_results.txt
done
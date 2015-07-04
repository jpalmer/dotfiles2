#!/bin/bash

declare -A MAP

MAP[~/.ssh/config]="config"

for K in "${!MAP[@]}"; 
do 
	
echo $K --- ${MAP[$K]}; 
ln -sf $(pwd)/${MAP[$K]} $K
done

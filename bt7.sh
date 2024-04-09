#!/bin/bash
max=$1
#for i in $@; do 
#    if [ $i -gt $max ]; then  
#        max=$i
#    fi
#done
#echo "Số lớn nhất là: $max"

max=$1
if [ $2 -gt $max ]; then
    max=$2
fi

if [ $max -lt $3 ]; then 
    max=$3
fi


max=$1
[ $2 -gt $max ] && max=$2
[ $max -lt $3 ] && max=$3

echo "Số lớn nhất là: $max"


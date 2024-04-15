#!/bin/bash
min = $1;
max = $1;

for i in $* ; do
    [ $i -lt $min ] && min=$i
    [ $i -gt $max ] && max=$i
done
echo "min la: $min"
echo "max la: $max"

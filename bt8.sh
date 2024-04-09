#!/bin/bash
max=$1
min=$1
for i in $*; do
    if [ $i -gt $max ]; then
        max=$i
    fi
    if [ $i -lt $min ]; then
        min=$i
    fi
done
echo "So lon nhat la: $max"
echo "So nho nhat la: $min"
#!/bin/bash
max=$1
for i in $*;do
    [ $i -gt $max ] && max=$i
done
echo "So lon nhat la: $max"
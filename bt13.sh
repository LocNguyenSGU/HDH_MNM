#!/bin/bash
while read line; do
    max=0
for i in `cat data.txt`; do   
    [ $i -gt $max ] && max=$i
done
echo "So lon nhat cau tung dong la: $max"
done < data.txt
#!/bin/bash

max=0
for i in `cat data.txt`; do   
    [ $i -gt $max ] && max=$i
done
echo "So lon nhat trong file la: $max"
#!/bin/bash

sum=0

! [ -f $1 ] && echo "file $1 khong ton tai" && exit 1

for i in `cat $1`; do
    sum=$((sum+i))
done
echo "tong cac so la: $sum"

#!/bin/bash
tong=0
for i in $*; do
    tong=$((tong + i))
done
echo "Tong cac doi so nhap tu dong lenh la: $tong"



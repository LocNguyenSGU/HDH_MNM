#!/bin/bash
# Lấy số lượng đối số
#count=$#
# Vòng lặp để xuất ngược từng tham số
#for ((i = count; i >= 1; i--)); do
#   echo "${!i}"
$done

for i in $* ; do
    res="$i $res"
done
echo $res


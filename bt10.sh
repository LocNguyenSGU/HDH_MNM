#!/bin/bash
# đếm sô lượng chữ số của số nguyên dương
count_number() { # viết thế này chỉ áp dụng với sô nhỏ
    num=$1
    count=0
    while [ $num -gt 0 ]; do
        count=$((count+1))
        num=$((num/10))
    done
    echo $count
}
count_number $1


len=`echo $1 | wc -c`
echo "So luong chu so: $((len - 1))" # -1 vi có 1 kí tự kết thúc chuỗi

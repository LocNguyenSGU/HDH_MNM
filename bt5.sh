#!/bin/bash
# Tổng ước của nó không chính nó bằng 0
is_perfect() {
    num=$1
    sum=0

    for ((i=1; i<num; i++)); do
        if [ $((num % i)) -eq 0 ]; then
            sum=$((sum+i))
        fi
    done

    if [ $sum -eq $num ]; then
        echo "$num la so hoan hao"
    else 
        echo "$num khong phai la so hoan hao"
    fi
}

read -p "Nhap vao mot so: " num
is_perfect $num

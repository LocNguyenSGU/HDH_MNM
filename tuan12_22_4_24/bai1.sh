#!/bin/bash

function binary() {
    num=$1
    bin=""
    while [ $num -gt 0 ]; do
        rem=$((num % 2))
        bin=$rem$bin
        num=$((num / 2))
    done
    echo $bin
}

function octal() {
    num=$1
    oct=""
    while [ $num -gt 0 ]; do
        rem=$((num % 8))
        oct=$rem$oct
        num=$((num / 8))
    done
    echo $oct
}

function hex() {
    num=$1
    hex=""
    while [ $num -gt 0 ]; do
        rem=$((num % 16))
        case $rem in
            10) hex="A$hex";;
            11) hex="B$hex";;
            12) hex="C$hex";;
            13) hex="D$hex";;
            14) hex="E$hex";;
            15) hex="F$hex";;
            *) hex="$rem$hex";;
        esac
        num=$((num / 16))
    done
    echo $hex
}

# Kiểm tra số lượng tham số và kiểm tra cơ số
if [ $# -ne 2 ] || [ $2 -ne 2 ] && [ $2 -ne 8 ] && [ $2 -ne 16 ] || [ "$1" -ne "$1" ]; then
    echo "Error"
    exit 1
fi

# Chuyển đổi số dựa trên cơ số được chỉ định
case $2 in
    2) echo "Số $1 chuyển sang nhị phân là: $(binary $1)";;
    8) echo "Số $1 chuyển sang bát phân là: $(octal $1)";;
    16) echo "Số $1 chuyển sang thập lục phân là: $(hex $1)";;
esac

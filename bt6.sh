#!/bin/bash

# Hàm kiểm tra số chính phương
is_ChinhPhuong() {
    local num=$1
    local sqrt_num=$(echo "sqrt($num)" | bc)  # Tính căn bậc hai của số

    if [ $((sqrt_num * sqrt_num)) -eq $num ]; then  # Kiểm tra xem căn bậc hai có phải là số nguyên không
        echo "$num là số chính phương"
    else
        echo "$num không phải là số chính phương"
    fi
}

# Chạy hàm với số được truyền vào từ dòng lệnh
is_ChinhPhuong $1

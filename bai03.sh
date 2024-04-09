#!/bin/bash

# Yêu cầu người dùng nhập vào số thứ nhất
echo -n "Nhap vao so thu nhat: "
read num1

# Yêu cầu người dùng nhập vào số thứ hai, không xuống dòng sau khi nhập (-n)
echo -n "Nhap vao so thu hai: "
read num2

# Tính tổng của hai số
tong=`expr $num1 + $num2`

# In ra tổng
echo "Tong hai so la: $tong"

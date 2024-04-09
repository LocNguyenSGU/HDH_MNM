#!/bin/bash
read -p "Nhap vao mot so: " num;
[ $num -eq $num 2>/dev/null ] && echo "$num la number" || echo "$num khong la number"
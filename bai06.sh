#!bin/bash
echo "Nhap vao mot so"
read num

if [ $num -eq $num 2>/dev/null ]; then
    echo "$num la number"
else 
    echo "$num khong phai la number"
fi
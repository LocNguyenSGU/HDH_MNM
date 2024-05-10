#!/bin/bash

random_number=$((RANDOM % 101))
count=0
startTime=$(date +%s)
while true; do
    read -p "Hãy đoán một số từ 0 đến 100: " num
    if [ $count -eq 10 ] || [ $(( $(date +%s) - $startTime )) -gt 20 ]; then
        echo "Bạn đã thua"
        echo "So can doan la: $random_number"
        break
    fi
    if [ $num -lt $random_number ]; then
        echo "Số bạn đoán nhỏ hơn số cần đoán"
        count=$((count+1))
    elif [ $num -gt $random_number ]; then
        echo "Số bạn đoán lớn hơn số cần đoán"
        count=$((count+1))
    else
        echo "Chúc mừng bạn đã đoán đúng"
        echo "Số lần bạn đoán là: $count"
        echo "Thời gian bạn đã đoán là: $(( $(date +%s) - $startTime )) giây"
        break
    fi
done


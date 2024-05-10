#!/bin/bash

# Khởi tạo biến sumip và sucess
sumip=0
sucess=0

while IFS= read -r line; do
    ((sumip++)) # Tăng giá trị của sumip lên 1
    ping -c1 $line &> /dev/null
    if [ $? -eq 0 ]; then
        echo "ip: $line -> ping thanh cong"
        ((sucess++)) # Tăng giá trị của sucess lên 1 nếu ping thành công
    else
        echo "ip: $line -> ping that bai"
    fi
done < ping.txt

echo "Tong so ip: $sumip"
echo "So ip ping thanh cong: $sucess"
echo "So ip ping that bai: $((sumip - sucess))"



#cach 2: dung for

#for ip in `cat ping.txt`; do   
#   echo $ip
#done
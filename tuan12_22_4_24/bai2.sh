#!/bin/bash

grep -i "$1" data.txt &> /dev/null
[ $? -ne 0 ] && echo "Không tìm thấy từ cần tra" && exit 1
while IFS= read -r line; do
    en=$(echo "$line" | cut -d ':' -f1)
    vi=$(echo "$line" | cut -d ':' -f2)
    [ "$en" == "$1" ] &&  echo "Tiếng Anh: $en -> Tiếng Việt: $vi" & continue
    [ "$vi" == "$1" ] &&  echo "Tiếng Việt: $vi -> Tiếng Anh: $en"
done < data.txt

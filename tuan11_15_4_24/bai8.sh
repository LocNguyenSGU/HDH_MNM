#!/bin/bash
file=$1
[ "$file" == "" ] && echo "Vui long nhap file" && exit 1
! [ -f $file ] && echo "File $file khong ton tai" && exit 1

echo "File $file ton tai"
output_file=`echo $file | tr '[:lower:]' '[:upper:]'`
echo "$output_file"
cat $file | tr '[a-z]' '[A-Z]' > $output_file

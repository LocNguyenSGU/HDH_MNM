#!/bin/bash

ls -li $1 &> /dev/null
[ $? -ne 0 ] && "echo Error: $1 is not a directory" && exit 1
quyen=`ls -li $1 | cut -d'@' -f1 | cut -d' ' -f2`
echo "Quyen cua $1 la: $quyen"

#!/bin/bash
random_number=$((RANDOM % 101))
while [ $random_number -ne $1 ]; do
    [ $random_number -lt $1 ] && echo "Chon so nho hon" || echo "Chon so lon hon"

done
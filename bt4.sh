#!/bin/bash
is_prime() {
    num=$1
    if [ $num -lt 2 ]; then  
        echo "$num không phải là số nguyên tố"
        return
    fi

    for (( i=2; i*i<=$num; i++ )); do
        if [ $((num % i)) -eq 0 ]; then   
            echo "$num không phải là số nguyên tố"
            return
        fi
    done
    echo "$num là số nguyên tố"
}

read -p "Nhập vào một số: " num
is_prime $num

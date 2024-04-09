#!/bin/bash

decimal_to_binary() {
    decimal=$1;
    binary=""
    while [ $decimal -gt 0 ]; do
        remainder=$((decimal % 2))
        binary="$remainder$binary"
        decimal=$((decimal / 2))
    done
    echo "So nhi phan la: $binary"
}
decimal_to_binary_2() {
    decimal=$1;
    binary=""
    while [ $decimal -gt 0 ]; do
       [ $((decimal % 2)) ] && binary="0$binary" || binary="1$binary"
        decimal=$((decimal / 2))
    done
    echo "So nhi phan la: $binary"
}
decimal_to_binary $1
decimal_to_binary_2 $1

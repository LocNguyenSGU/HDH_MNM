#!/bin/bash
is_prime() {
    if [ $1 < 2 ]
        return 1
    for (( i=2; i*i<=$1; i++ )); do
        [ $(($1 % i)) -eq 0 ] && return 1
    done
    return 0
}
! [ -f $1 ] && echo "file $1 khong ton tai" && exit 1

for i in `cat $1`; do
    ! [ $i -eq $i 2>/dev/null ] && continue
    is_prime $i
    [ $? -eq 0 ] && echo "$i la SNT"
done
echo "tong cac so la: $sum"

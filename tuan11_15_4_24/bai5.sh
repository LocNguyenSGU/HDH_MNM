#!/bin/bash

ping -c1 $1 &> /dev/null
[ $? -ne 0 ] && echo "Khong tim thay domain" && exit 1
ip=`ping -c1 $1 | grep PING | cut -d'(' -f2 | cut -d')' -f1`
echo "IP cua domain $1 la: $ip"



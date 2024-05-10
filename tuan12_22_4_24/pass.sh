#!/bin/bash
while(true); do
    data=$(head -c20 /dev/urandom | base64)
    pass=${data:1:8}
    #passs=$(echo "$data" | cut -c1-8)
    echo $pass | grep '[0-9]' &> dev/null
    [ $? -eq 0 ] && break;
done
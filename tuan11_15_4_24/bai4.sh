#!/bin/bash

[ "$1" == "" ] && path="." || path=$1  
function list_directories() {
    for file in $1/*; do
        if [ -d $file ]; then
            echo $file
            list_directories $file
        fi
    done
}
list_directories $path

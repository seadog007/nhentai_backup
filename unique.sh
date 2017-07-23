#!/bin/bash

[ -z "$1" ] && echo 'Usage: ./unique.sh <file_you_want_to_unique>' && exit 1

sort -nu $1 > s
mv s $1

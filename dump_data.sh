#!/bin/bash

if [ -n "$1" ]
then
    line=$1
	clear
	if [ -z "`grep $line json_fetched`" ]
	then
		echo "Fetching $line"
		mongo 127.0.0.1:18888/nhentai --eval "db.nhentai.insert(`curl -s --proxy proxy.hinet.net:80 https://nhentai.net/g/$line/ | grep -oP 'var gallery = new N.gallery\(\K.*(?=\);)'`)"
		echo "$line" >> json_fetched
	else
		echo "$line Already Fetched"
	fi
else
	#reqiored GNU parallel that has --bar (20161222)
	cat list | parallel --bar -j 50 $0
fi


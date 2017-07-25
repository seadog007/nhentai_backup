#!/bin/bash

while read line
do
	if [ -z "`grep $line json_fetched`" ]
	then
		echo "Fetching $line"
		mongo 127.0.0.1:18888 nhentai --eval "db.nhentai.insert(`curl --proxy proxy.hinet.net:80 https://nhentai.net/g/$line/ | grep -oP 'var gallery = new N.gallery\(\K.*(?=\);)'`)"
		echo "$line" >> json_fetched
	else
		echo "$line Already Fetched"
	fi
done < list

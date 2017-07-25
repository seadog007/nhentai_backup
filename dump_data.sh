#!/bin/bash

function download {
    line=$1
	if [ -z "`grep $line json_fetched`" ]
	then
		echo "Fetching $line"
		mongo 127.0.0.1:18888 nhentai --eval "db.nhentai.insert(`curl --proxy proxy.hinet.net:80 https://nhentai.net/g/$line/ | grep -oP 'var gallery = new N.gallery\(\K.*(?=\);)'`)"
		echo "$line" >> json_fetched
	else
		echo "$line Already Fetched"
	fi
}

export -f download
cat list | parallel --bar -j 10 download

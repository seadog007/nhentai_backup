#!/bin/bash

#https://nhentai.net/g/$id/
#https://t.nhentai.net/galleries/$id/cover.png
#https://i.nhentai.net/galleries/$id/$page.png

if [ -n "$1" ]
then
	part=10000
	declare -A mediatype
	mediatype=( ["j"]="jpg" ["p"]="png" ["g"]="gif" )

	line=$1
	id=$(echo $line | awk -F, '{print $1}')
	pagenum=$(echo $line | awk -F, '{print $2}')
	mediaid=$(echo $line | awk -F, '{print $3}')
	covertype=${mediatype["$(echo $line | awk -F, '{print $4}')"]}
	pagetypes=$(echo $line | awk -F, '{print $5}')

	if [ -z "`grep $id media_fetched`" ]
	then
		cd downloads
		dir=$(($(($id / $part)) * $part))/$id
		mkdir -p $dir
		cd $dir
		echo "Fetching cover of $id"
		echo 'https://t.nhentai.net/galleries/'$mediaid'/cover.'$covertype
		curl -s -O 'https://t.nhentai.net/galleries/'$mediaid'/cover.'$covertype
		echo "Pages Type: $pagetypes"
		for page in `seq $pagenum`
		do
			pagetype=${mediatype["${pagetypes:$(($page - 1)):1}"]}
			echo "Fetching page $page of $pagenum, Book ID: $id, Type: $pagetype"
			curl -s -O 'https://i.nhentai.net/galleries/'$mediaid'/'$page'.'$pagetype
		done
		cd ../../../
		echo "$id" >> media_fetched
	else
		echo "$id Already Fetched"
	fi
else
	#reqiored GNU parallel that has --bar (20161222)
	cat mongodb/pageinfo.csv | parallel --bar -j 50 $0
fi


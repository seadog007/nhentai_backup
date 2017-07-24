#!/bin/bash

while read line
do
mongo 127.0.0.1:18888 nhentai --eval "db.nhentai.insert(`curl -v --proxy proxy.hinet.net:80 https://nhentai.net/g/$line/ | grep -oP 'var gallery = new N.gallery\(\K.*(?=\);)'`)"
done < list

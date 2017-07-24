#!/bin/bash

while read line
do
mongo nhentai --eval "db.nhentai.insert(`curl -v --proxy proxy.hinet.net:80 https://nhentai.net/g/$line/ | grep -oP 'var gallery = new N.gallery\(\K.*(?=\);)'`)"
done < list

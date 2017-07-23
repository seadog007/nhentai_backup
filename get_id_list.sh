#!/bin/bash

for i in `seq 7889 7891`
do
	echo -e "Page:\t$i"
	curl -s --proxy proxy.hinet.net:80 "https://nhentai.net/?page=$i" | grep -oP 'href="/g/\K[0-9]+' >> list
done
./unique.sh list

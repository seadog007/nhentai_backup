#!/bin/bash

function finish {
	./unique.sh list
}
trap finish EXIT

for i in `seq $1`
do
	echo -e "Page:\t$i"
	curl -s --proxy proxy.hinet.net:80 "https://nhentai.net/?page=$i" | grep -oP 'href="/g/\K[0-9]+' >> list
done

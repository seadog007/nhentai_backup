#!/bin/bash

mongoexport --host 127.0.0.1 --port 18888 -dnhentai -cnhentai --fields id,num_pages,media_id,images \
	| jq -r '[(.id|tostring),(.num_pages|tostring),.media_id,([.images.cover.t]|join("")),([.images.pages[].t]|join(""))]|join(",")' > temp
sort -t, -k1n,1 temp > pageinfo.csv
rm temp

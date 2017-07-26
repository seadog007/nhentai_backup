#!/bin/bash

mongoexport --host 127.0.0.1 --port 18888 -dnhentai -cnhentai --fields id,num_pages,media_id --type=csv --out temp
sed -i 1d temp
sort -t, -k1n,1 temp > pagenum.csv
rm temp

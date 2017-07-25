#!/bin/bash

mongoexport --host 127.0.0.1 --port 18888 -dnhentai -cnhentai --fields id,title,tag --out grep.json

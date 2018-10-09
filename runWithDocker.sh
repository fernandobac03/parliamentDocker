#!/bin/bash

docker stop parliament
docker rm parliament
docker run -d --name parliament -p 8089:8089 -v volparliament:/usr/local/ParliamentKB/data cepraxi/parliament

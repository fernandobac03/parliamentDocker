#!/bin/bash
docker stop parliament1
docker rm parliament1
docker rmi parliament-2.7.10_img
docker build --rm=true --tag="parliament-2.7.10_img" .

docker run -d --name="parliament1" -p 49701:49701 -p 8089:8089 parliament-2.7.10_img
docker ps
#rm ~/.ssh/known_hosts
#ssh -p 49701 root@localhost

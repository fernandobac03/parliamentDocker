#!/bin/bash
docker stop parliament1
docker rm parliament1
docker rmi parliament_img
docker build --rm=true --tag="parliament_img" .

docker run -d --name="parliament1" -p 49701:49701 -p 49702:49702 parliament_img
docker ps
#rm ~/.ssh/known_hosts
#ssh -p 49701 root@localhost
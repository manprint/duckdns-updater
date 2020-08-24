#!/bin/bash

echo "Script name: run duckdns client"
echo "*******************************"

NAME=duckdns-updater
HOSTNAME=ubuntu-server

docker stop $NAME
docker rm $NAME

docker run -dit \
	--name=$NAME \
	--hostname=$HOSTNAME \
	--privileged \
	--restart=always \
	-v $(pwd)/environment:/lib/systemd/system/environment \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	duckdns-updater:latest

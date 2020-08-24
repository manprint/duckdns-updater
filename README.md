# DuckDns Updater

## Use

### Environment file

Create an environment file as follow

```
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

TOKEN=duckdns-token
DOMAIN=your-ddns-domain-name
```

### Run

Create a run script as follow

```
#!/bin/bash

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
```


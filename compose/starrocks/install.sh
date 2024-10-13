#!/usr/bin/env bash

IMAGE_VERSION=3.2
sed -i "s/\${IMAGE_VERSION}/$IMAGE_VERSION/g" docker-compose.yaml

mkdir data data/meta1 data/meta2 data/meta3 data/storage1 data/storage2 data/storage3
mkdir log log/fe1 log/fe2 log/fe3 log/cn1 log/cn2 log/cn3

if [ `docker network ls | grep -o starrocks` ]; then
  echo -e "\033[32mnetwork starrocks already exists, skip to create it...\033[0m"
else
  docker network create --driver bridge --subnet=172.90.30.0/24 starrocks
fi

docker-compose up -d

echo 'Waiting FE nodes to ready'
sleep 10

# add fe follower/observer  ip:edit_log_port
for i in starrocks-fe-2 starrocks-fe-3; do
    ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $i)
    mysql -h 127.0.0.1 -P9030 -uroot -e "
    alter system add follower '$ip:9010';
    "
done

# add cn  ip:heartbeat_service_port
for i in starrocks-cn-1 starrocks-cn-2 starrocks-cn-3; do
    ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $i)
    mysql -h 127.0.0.1 -P9030 -uroot -e "
    alter system add compute node '$ip:9050';
    "
done

mysql -h 127.0.0.1 -P9030 -uroot -e "show frontends; show compute nodes;"

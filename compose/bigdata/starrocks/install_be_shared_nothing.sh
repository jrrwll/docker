#!/usr/bin/env bash

IMAGE_VERSION=3.2

cp docker-compose.template.yaml docker-compose.yaml
sed -i "s/\${IMAGE_VERSION}/$IMAGE_VERSION/g" docker-compose.yaml

# config files and workdir
mkdir -p data/meta1 data/meta2 data/meta3 data/storage1 data/storage2 data/storage3
mkdir -p log/fe1 log/fe2 log/fe3 log/be1 log/be2 log/be3

# delete cn in docker-compose.yaml
awk '
    /cn1:/   { skip=1; next }
    /^networks:/   { skip=0 }
    !skip
' docker-compose.yaml > docker-compose.yaml.tmp
mv docker-compose.yaml.tmp docker-compose.yaml
sed -i '/run_mode/,$d' conf/fe.conf

# docker
if [ "$(docker network ls | grep -o dev)" ]; then
    echo -e "\033[32mnetwork dev already exists, skip to create it...\033[0m"
else
    docker network create --driver bridge dev
fi

docker-compose up -d

echo 'waiting FE nodes to ready'
timeout=15
count=0
while [ "$(docker inspect --format='{{.State.Health.Status}}' starrocks-fe1)" != 'healthy' ] && [ $count -lt $timeout ]; do
    echo -n '.'
    sleep 1
    count=$((count + 1))
done
echo -n '\n'
if [ $count -ge $timeout ]; then
    echo -e "\ntimeout: FE node not ready within 15 seconds."
fi

# add fe follower/observer ip:edit_log_port
for i in starrocks-fe2 starrocks-fe3; do
    ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $i)
    mysql -h 127.0.0.1 -P9030 -uroot -e "
    alter system add follower '$ip:9010';
    "
done

# add be ip:heartbeat_service_port
for i in starrocks-be1 starrocks-be2 starrocks-be3; do
    ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $i)
    mysql -h 127.0.0.1 -P9030 -uroot -e "
    alter system add backend '$ip:9050';
    "
done

mysql -h 127.0.0.1 -P9030 -uroot -e "show frontends; show backends;"

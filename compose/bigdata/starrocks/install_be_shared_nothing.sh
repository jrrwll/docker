#!/usr/bin/env bash

IMAGE_VERSION=3.2
SUBNET_PREFIX=172.90.30

cp docker-compose.template.yaml docker-compose.yaml
sed -i "s/\${IMAGE_VERSION}/$IMAGE_VERSION/g" docker-compose.yaml
sed -i "s/\${SUBNET_PREFIX}/$SUBNET_PREFIX/g" docker-compose.yaml

# config files and workdir
cp conf/fe.template.conf conf/fe.conf
sed -i "s/\${SUBNET_PREFIX}/$SUBNET_PREFIX/g" conf/fe.conf
cp conf/be.template.conf conf/be.conf
sed -i "s/\${SUBNET_PREFIX}/$SUBNET_PREFIX/g" conf/be.conf

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
if [ "$(docker network ls | grep -o starrocks)" ]; then
    echo -e "\033[32mnetwork starrocks already exists, skip to create it...\033[0m"
else
    docker network create --driver bridge --subnet "$SUBNET_PREFIX.0/24" starrocks
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
echo

if [ $count -ge $timeout ]; then
    echo -e "timeout: FE node not ready within 15 seconds.\n"
fi

# add fe follower/observer ip:edit_log_port
for i in starrocks-fe2 starrocks-fe3; do
    ip=$(docker inspect -f '{{.NetworkSettings.Networks.starrocks.IPAddress}}' $i)
    mysql -h 127.0.0.1 -P9030 -uroot -e "
    alter system add follower '$ip:9010';
    "
done

# add be ip:heartbeat_service_port
for i in starrocks-be1 starrocks-be2 starrocks-be3; do
    ip=$(docker inspect -f '{{.NetworkSettings.Networks.starrocks.IPAddress}}' $i)
    mysql -h 127.0.0.1 -P9030 -uroot -e "
    alter system add backend '$ip:9050';
    "
done

mysql -h 127.0.0.1 -P9030 -uroot -e "show frontends; show backends;"

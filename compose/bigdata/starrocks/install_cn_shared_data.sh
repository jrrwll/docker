#!/usr/bin/env bash

IMAGE_VERSION=3.2
SUBNET_PREFIX=172.90.30

cp docker-compose.template.yaml docker-compose.yaml
sed -i "s/\${IMAGE_VERSION}/$IMAGE_VERSION/g" docker-compose.yaml
sed -i "s/\${SUBNET_PREFIX}/$SUBNET_PREFIX/g" docker-compose.yaml

# config files and workdir
cp conf/fe.template.conf conf/fe.conf
sed -i "s/\${SUBNET_PREFIX}/$SUBNET_PREFIX/g" conf/fe.conf
cp conf/cn.template.conf conf/cn.conf
sed -i "s/\${SUBNET_PREFIX}/$SUBNET_PREFIX/g" conf/cn.conf

mkdir -p data/meta1 data/meta2 data/meta3 data/storage1 data/storage2 data/storage3
mkdir -p log/fe1 log/fe2 log/fe3 log/cn1 log/cn2 log/cn3

# delete be in docker-compose.yaml
awk '
    /be1:/   { skip=1; next }   # skip be1 line
    /cn1:/   { skip=0 }         # close skip when reach cn1 line
    !skip                    # print lines when not skipping
' docker-compose.yaml > docker-compose.yaml.tmp
mv docker-compose.yaml.tmp docker-compose.yaml

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

# add cn ip:heartbeat_service_port
for i in starrocks-cn1 starrocks-cn2 starrocks-cn3; do
    ip=$(docker inspect -f '{{.NetworkSettings.Networks.starrocks.IPAddress}}' $i)
    mysql -h 127.0.0.1 -P9030 -uroot -e "
    alter system add compute node '$ip:9050';
    "
done

mysql -h 127.0.0.1 -P9030 -uroot -e "show frontends; show compute nodes;"

echo '
you need config s3/hdfs first before use the starrocks cluster
you can refer to the following sql:
'

cat <<EOF
create storage volume default_storage_volume
    type = s3 locations = ("s3://starrocks")
    properties (
        "enabled" = "true",
        "aws.s3.region" = "us-east1",
        "aws.s3.endpoint" = "***",
        "aws.s3.access_key" = "***",
        "aws.s3.secret_key" = "***",
        "aws.s3.enable_partitioned_prefix" = "true"
    );
set default_storage_volume as default storage volume;

show storage volumes;
EOF

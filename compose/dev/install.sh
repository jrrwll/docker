#!/usr/bin/env bash

PASSWORD=root
sed -i "s/\${PASSWORD}/$PASSWORD/g" docker-compose.yaml

docker-compose up -d
# uid 1001 for kafka
sudo chown -R "1001:$(id -g -n)" kafka37

LOCAL_IP=
sed -i "s/\${LOCAL_IP}/$LOCAL_IP/g" dev.dreamcat.org.conf
mv dev.dreamcat.org.conf nginx/
# docker exec -it nginx nginx -s reload
docker exec -it nginx nginx -t

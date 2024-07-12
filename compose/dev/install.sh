#!/usr/bin/env bash

PASSWORD=root
sed -i "s/\${PASSWORD}/$PASSWORD/g" docker-compose.yaml

docker-compose up -d
# uid 1001 for kafka
sudo chown -R "1001:$(id -g -n)" kafka37

docker-compose ps -a

LOCAL_IP=
sed -i "s/\${LOCAL_IP}/$LOCAL_IP/g" nginx/dev.dreamcat.org.conf
# docker exec -it nginx nginx -s reload

(docker ps --format 'table {{.Names}}' | grep nginx) && docker exec -it nginx nginx -t

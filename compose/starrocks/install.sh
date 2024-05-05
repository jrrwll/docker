#!/usr/bin/env bash

PASSWORD=
sed -i "s/\${PASSWORD}/$PASSWORD/g" docker-compose.yaml

docker-compose up -d
# uid 1001 for kafka
sudo chown -R "1001:$(id -g -n)" kafka37


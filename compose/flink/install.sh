#!/usr/bin/env bash

PASSWORD=
sed -i "s/\${PASSWORD}/$PASSWORD/g" docker-compose.yaml

docker-compose up -d


#!/usr/bin/env bash

PASSWORD=
#LOCAL_PATH=$(cd . && pwd -P)
LOCAL_PATH=.

sed -i "s/\${PASSWORD}/$PASSWORD/g" docker-compose.yaml
sed -i "s/\${LOCAL_PATH}/$LOCAL_PATH/g" docker-compose.yaml

docker-compose up -d
# own the LOCAL_PATH for current user
sudo chown -R "$(id -u -n):$(id -g -n)" $LOCAL_PATH
# uid 10000 for pulsar
sudo chown -R "10000:$(id -g -n)" pulsar300

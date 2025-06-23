#!/usr/bin/env bash

cd zookeeper
mkdir data
mkdir data

docker run -itd --name zookeeper \
    --network dev \
    -p 2181:2181 \
    -e TZ="Asia/Shanghai" \
    -v ./data:/data \
    zookeeper


docker exec -it zookeeper ./bin/zkServer.sh status

docker run -it --rm --network dev \
  zookeeper zkCli.sh -server zookeeper

# ls /

#!/usr/bin/env bash

if [ "$1" = "centos" ]; then
    docker build -t foekut/nexus -f centos.Dockerfile .
    docker tag foekut/nexus foekut/nexus:3
    docker tag foekut/nexus foekut/nexus:3.16.1
    exit 0
fi

docker build -t tukeof/nexus -f Dockerfile .
docker tag tukeof/nexus tukeof/nexus:3
docker tag tukeof/nexus tukeof/nexus:3.16.1


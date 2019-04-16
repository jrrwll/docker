#!/usr/bin/env bash

if [ "$1" = "centos" ]; then
    docker build -t tukeof/oraclejre-centos -f oraclejre-centos.Dockerfile .

    docker tag tukeof/oraclejre-centos tukeof/oraclejre-centos:8
    docker tag tukeof/oraclejre-centos tukeof/oraclejre-centos:1.8.0_191
    exit 0
fi

docker build -t tukeof/oraclejre .

docker tag tukeof/oraclejre tukeof/oraclejre:8
docker tag tukeof/oraclejre tukeof/oraclejre:1.8.0_191



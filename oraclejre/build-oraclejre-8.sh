#!/usr/bin/env bash

cd `dirname $0`
if [ "$1" = "centos" ]; then
    docker build -t foekut/oraclejre -f centos.Dockerfile .
    docker tag foekut/oraclejre foekut/oraclejre:8
    docker tag foekut/oraclejre foekut/oraclejre:1.8.0
    docker tag foekut/oraclejre foekut/oraclejre:1.8.0_211
    exit 0
fi

docker build -t tukeof/oraclejre .
docker tag tukeof/oraclejre tukeof/oraclejre:8
docker tag tukeof/oraclejre tukeof/oraclejre:1.8.0
docker tag tukeof/oraclejre tukeof/oraclejre:1.8.0_211



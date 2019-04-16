#!/usr/bin/env bash

cd `dirname $0`
if [ "$1" = "centos" ]; then
    docker build -t tukeof/oraclejdk-centos -f oraclejdk-centos.Dockerfile .

    docker tag tukeof/oraclejdk-centos tukeof/oraclejdk-centos:8
    docker tag tukeof/oraclejdk-centos tukeof/oraclejdk-centos:1.8.0_191
    exit 0
fi

docker build -t tukeof/oraclejdk .

docker tag tukeof/oraclejdk tukeof/oraclejdk:8
docker tag tukeof/oraclejdk tukeof/oraclejdk:1.8.0_191



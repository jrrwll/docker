#!/usr/bin/env bash

if [ "$1" = "centos" ]; then
    docker build -t tukeof/fatopenjdk:8-centos -f centos.Dockerfile .
    docker tag tukeof/fatopenjdk:8-centos tukeof/fatopenjdk:centos
    docker tag tukeof/fatopenjdk:8-centos tukeof/fatopenjdk:centos7
    exit 0
fi

docker build -t tukeof/fatopenjdk -f Dockerfile .
docker tag tukeof/fatopenjdk tukeof/fatopenjdk:8-debian
docker tag tukeof/fatopenjdk tukeof/fatopenjdk:8-debian9
docker tag tukeof/fatopenjdk tukeof/fatopenjdk:debian9
docker tag tukeof/fatopenjdk tukeof/fatopenjdk:debian

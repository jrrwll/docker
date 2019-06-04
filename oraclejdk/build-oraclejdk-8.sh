#!/usr/bin/env bash

cd `dirname $0`
if [ "$1" = "centos" ]; then
    docker build -t foekut/oraclejdk -f centos.Dockerfile .

    docker tag foekut/oraclejdk foekut/oraclejdk:8
    docker tag foekut/oraclejdk foekut/oraclejdk:1.8.0
    docker tag foekut/oraclejdk foekut/oraclejdk:1.8.0_211
    exit 0
fi

docker build -t tukeof/oraclejdk .
docker tag tukeof/oraclejdk tukeof/oraclejdk:8
docker tag tukeof/oraclejdk tukeof/oraclejdk:1.8.0
docker tag tukeof/oraclejdk tukeof/oraclejdk:1.8.0_211



#!/usr/bin/env bash

if [ "$1" = "centos" ]; then
    docker build -t foekut/fatopenjdk -f centos.Dockerfile .
    exit 0
fi

docker build -t tukeof/fatopenjdk -f Dockerfile .

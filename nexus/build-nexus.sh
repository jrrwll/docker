#!/usr/bin/env bash

if [ "$1" = "centos" ]; then
    docker build -t tukeof/nexus:centos -f centos.Dockerfile .
    exit 0
fi

docker build -t tukeof/nexus -f Dockerfile .

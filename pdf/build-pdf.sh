#!/usr/bin/env bash

cd `dirname $0`

if [ "$1" = "centos" ]; then
    docker build -t tukeof/pdf-centos -f pdf-centos.Dockerfile .

    docker tag tukeof/pdf-centos tukeof/pdf-centos:1.14.0
    exit 0
fi

docker build -t tukeof/pdf .

docker tag tukeof/pdf tukeof/pdf:1.14.0


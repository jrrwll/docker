#!/usr/bin/env bash

cd `dirname $0`


if [ "$1" = "centos" ]; then
    docker build -t tukeof/pdf-jre-centos -f pdf-jre-centos.Dockerfile .

    docker tag tukeof/pdf-jre-centos tukeof/pdf-jre-centos:1.14.0
    exit 0
fi

docker build -t tukeof/pdf-jre .

docker tag tukeof/pdf-jre tukeof/pdf-jre:1.14.0


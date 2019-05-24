#!/usr/bin/env bash

cd `dirname $0`

if [ "$1" = "centos" ]; then
    docker build -t tukeof/image-jre-centos -f image-jre-centos.Dockerfile .
    exit 0
fi

docker build -t tukeof/image-jre -f image-jre.Dockerfile .


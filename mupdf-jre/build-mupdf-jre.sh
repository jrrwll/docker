#!/usr/bin/env bash

cd `dirname $0`


if [ "$1" = "centos" ]; then
    docker build -t tukeof/mupdf-jre-centos -f mupdf-jre-centos.Dockerfile .

    docker tag tukeof/mupdf-jre-centos tukeof/mupdf-jre-centos:1.14.0
    exit 0
fi

docker build -t tukeof/mupdf-jre .

docker tag tukeof/mupdf-jre tukeof/mupdf-jre:1.14.0


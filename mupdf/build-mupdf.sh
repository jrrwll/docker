#!/usr/bin/env bash

cd `dirname $0`

if [ "$1" = "centos" ]; then
    docker build -t tukeof/mupdf-centos -f mupdf-centos.Dockerfile .

    docker tag tukeof/mupdf-centos tukeof/mupdf-centos:1.14.0
    exit 0
fi

docker build -t tukeof/mupdf .

docker tag tukeof/mupdf tukeof/mupdf:1.14.0


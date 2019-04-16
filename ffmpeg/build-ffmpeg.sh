#!/usr/bin/env bash

cd `dirname $0`

if [ "$1" = "centos" ]; then
    docker build -t tukeof/ffmpeg-centos -f ffmpeg-centos.Dockerfile .

    exit 0
fi

docker build -t tukeof/ffmpeg .

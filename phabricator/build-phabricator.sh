#!/usr/bin/env bash

if [ "$1" = "centos" ]; then
    docker build -t foekut/phabricator -f centos.Dockerfile .
    exit 0
fi

docker build -t tukeof/phabricator .

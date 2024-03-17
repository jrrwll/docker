#!/usr/bin/env bash

cd `dirname $0`

docker build -t jerrywill/oraclejre .
docker tag jerrywill/oraclejre jerrywill/oraclejre:8
docker tag jerrywill/oraclejre jerrywill/oraclejre:1.8
docker tag jerrywill/oraclejre jerrywill/oraclejre:1.8.0_261

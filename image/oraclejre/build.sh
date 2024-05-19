#!/usr/bin/env bash

cd "$(dirname $0)" || exit 1

docker build -t jerrywill/oraclejre .
docker tag jerrywill/oraclejre jerrywill/oraclejre:8
docker tag jerrywill/oraclejre jerrywill/oraclejre:1.8
docker tag jerrywill/oraclejre jerrywill/oraclejre:1.8.0_414

docker push jerrywill/oraclejre
docker push jerrywill/oraclejre:8
docker push jerrywill/oraclejre:1.8
docker push jerrywill/oraclejre:1.8.0_414

#!/usr/bin/env bash

cd `dirname $0`
echo "work on `pwd`"

cp ../jdk8/jdk-8u191-linux-x64.tar.gz .

docker build -t tukeof/hadoop:3.1.1 .

docker tag tukeof/hadoop:3.1.1 tukeof/hadoop:3
docker tag tukeof/hadoop:3.1.1 tukeof/hadoop

rm jdk-8u191-linux-x64.tar.gz

#dk run --name had -it -d \
#    -p 50070:50070 -p 8088:8088 -p 19888:19888 \
#   tukeof/hadoop

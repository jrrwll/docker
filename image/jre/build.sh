#!/usr/bin/env bash

NAME=zulu17.50.19-ca-jre17.0.11-linux_x64
tar xfvz $NAME.tar.gz
mv $NAME jre17.0.11
tar cfvz jre17.0.11.tar.gz jre17.0.11/

docker build -f 17.Dockerfile -t jerrywill/jre:17 .

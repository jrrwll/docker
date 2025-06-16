#!/usr/bin/env bash

docker run -itd --name nacos \
    --network dev \
    -p 8848:8848 \
    -p 9848:9848 \
    -e PREFER_HOST_MODE=hostname \
    -e MODE=standalone \
    -e SPRING_DATASOURCE_PLATFORM=mysql \
    -e MYSQL_SERVICE_HOST=mysql57 \
    -e MYSQL_SERVICE_PORT=3306 \
    -e MYSQL_SERVICE_USER=nacos \
    -e MYSQL_SERVICE_PASSWORD=nacos \
    -e MYSQL_SERVICE_DB_NAME=nacos \
    -v ./logs:/home/nacos/logs \
    nacos/nacos-server

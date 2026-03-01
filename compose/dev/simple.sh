#!/usr/bin/env bash

docker run -d \
  --name mysql57 \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_CHARSET=utf8mb4 \
  -e MYSQL_COLLATION=utf8mb4_unicode_ci \
  -v $PWD/mysql57:/var/lib/mysql \
  -p 3306:3306 \
  mysql:5.7 \
  --server-id=1 --log-bin=mysql-bin \
  --character-set-server=utf8mb4 \
  --character-set-client=utf8mb4 \
  --collation-server=utf8mb4_unicode_ci

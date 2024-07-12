#!/usr/bin/env bash

mkdir conf data logs etcd_data apisix/logs

docker-compose up -d
# uid 1001 for etcd
sudo chown -R "1001:$(id -g -n)" etcd

#character_set_server=utf8
#lower_case_table_names=1
#group_concat_max_len=1024000
docker exec -it mysql mysql -uroot -p -e "
CREATE DATABASE IF NOT EXISTS dataease DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
"

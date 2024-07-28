#!/usr/bin/env bash

# a init SQL to create tables and insert data
[[ ! -f mysql-schema.sql ]] && \
wget https://raw.githubusercontent.com/alibaba/nacos/develop/distribution/conf/mysql-schema.sql

docker cp mysql-schema.sql mysql57:/

docker exec -it mysql57 mysql -uroot -p -e "
create database nacos;

create user 'nacos'@'%' identified by 'nacos';
grant all privileges on nacos.* to 'nacos'@'%' identified by 'nacos';
flush privileges;

use nacos;
source /mysql-schema.sql;
"

docker exec -it mysql57 mysql -unacos -pnacos -e 'show tables from nacos;'

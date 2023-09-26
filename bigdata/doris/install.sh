#!/usr/bin/env bash

docker-compose up -d
# sudo apt install default-mysql-client
docker run --network bigdata -it --rm freeoneplus/apache-doris:register bash

# no password required
mysql -h 172.20.80.2 -P 9030 -uroot

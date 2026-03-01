#!/usr/bin/env bash

docker run -d --name debezium \
    --network dev -p 8083:8083 \
    -e GROUP_ID=1 \
    -e CONFIG_STORAGE_TOPIC=debezium_connect_configs \
    -e OFFSET_STORAGE_TOPIC=debezium_connect_offsets \
    -e STATUS_STORAGE_TOPIC=debezium_connect_statuses \
    -e BOOTSTRAP_SERVERS=kafka:9092 \
    quay.io/debezium/connect

mysql -h 127.0.0.1 -P3306 -uroot -p -e "
create user 'debezium'@'%' identified by 'debezium';
grant select, reload, show databases, replication slave, replication client on *.* to 'debezium'@'%';
"

# create connector
# python3 -c "import json5, json; print(json.dumps(json5.load(open('mysql.jsonc')), indent=2))"
curl -X POST localhost:8083/connectors/ \
    -H "Content-Type:application/json" \
    -d @mysql.json | jq

curl http://localhost:8083/connectors/mysql-connector/status | jq

# curl -v -X DELETE http://localhost:8083/connectors/mysql-connector

docker exec -it kafka kafka-topics.sh --bootstrap-server localhost:9092 --list

docker exec -it kafka kafka-console-consumer.sh \
    --bootstrap-server localhost:9092 \
    --from-beginning --topic my_topic

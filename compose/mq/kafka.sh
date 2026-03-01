#!/usr/bin/env bash

mkdir kafka
# uid 1001 for kafka
sudo chown -R "1001:$(id -g -n)" kafka

docker run -d \
  --name kafka \
  --network dev \
  -p 9092:9092 \
  -v ${PWD}/kafka:/bitnami/kafka \
  -e TZ=Asia/Shanghai \
  -e KAFKA_CFG_NODE_ID=0 \
  -e KAFKA_CFG_PROCESS_ROLES=controller,broker \
  -e KAFKA_CFG_LISTENERS=PLAINTEXT://:9092,CONTROLLER://:9093 \
  -e KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT \
  -e KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=0@kafka:9093 \
  -e KAFKA_CFG_CONTROLLER_LISTENER_NAMES=CONTROLLER \
  bitnami/kafka:3.7

docker run -d \
  --name kafka-ui \
  --network dev \
  -p 9093:8080 \
  -e TZ=Asia/Shanghai \
  -e KAFKA_CLUSTERS_0_NAME=local \
  -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=kafka:9092 \
  provectuslabs/kafka-ui

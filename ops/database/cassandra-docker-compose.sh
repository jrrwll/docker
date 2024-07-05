#!/usr/bin/env bash

cd `dirname $0`
docker-compose -f cassandra-docker-compose.yml up -d
docker exec cassandra0 nodetool status

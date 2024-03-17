#!/bin/bash

hdfs_pods=(namenode datanode resourcemanager nodemanager historyserver)
hive_pods=(hive-metastore hive-server) # hive-presto
all_pods=("${hdfs_pods[@]}" "${hive_pods[@]}")

# 1. install krb5 client
for i in "${hive_pods[@]}"; do
  docker cp ./debian8-jessie-sources.list $i:/etc/apt/sources.list
done
for i in "${hdfs_pods[@]}"; do
  docker cp ./debian9-stretch-sources.list $i:/etc/apt/sources.list
done

for i in "${all_pods[@]}"; do
  echo "install krb5 client for $i"
  docker exec -u root $i cat /etc/apt/sources.list
  docker exec -u root $i bash -c 'apt-get update && apt-get install krb5-user -y --force-yes'
done

# 2. create principal and configure hdfs & hive
bash configure-build.sh "$@"


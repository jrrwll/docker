#!/bin/bash

KRB5_DOMAIN=$1
if [ -z $KRB5_DOMAIN ]; then KRB5_DOMAIN=my.domain; fi

hive_pods=(hive-metastore hive-server) # hive-presto
hdfs_pods=(namenode datanode resourcemanager nodemanager historyserver)
all_pods=("${hdfs_pods[@]}" "${hive_pods[@]}")

for i in "${all_pods[@]}"; do
  echo "$i" && docker exec $i klist
done

for i in "${hdfs_pods[@]}"; do
  echo "kinit for $i" && docker exec $i kinit -k -t /etc/hdfs.keytab hdfs/$KRB5_DOMAIN
done

for i in "${hive_pods[@]}"; do
  echo "kinit for $i" && docker exec $i kinit -k -t /etc/hive.keytab hive/$KRB5_DOMAIN
done

for i in "${all_pods[@]}"; do
  echo "$i" && docker exec $i klist
done

for i in "${hdfs_pods[@]}"; do
  docker exec $i kinit -k -t /etc/hdfs.keytab HTTP/$i
  echo "$i" && docker exec $i klist
done

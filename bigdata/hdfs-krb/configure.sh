#!/bin/bash

if [ -z $1 ]; then
  echo "need one arg to specify KRB5_IP"
  exit 1
fi

KRB5_IP=$1
KRB5_DOMAIN=$2
KRB5_REALM=$3
if [ -z $KRB5_DOMAIN ]; then KRB5_DOMAIN=my.domain; fi
if [ -z $KRB5_REALM ]; then KRB5_REALM=MY.DOMAIN; fi

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
docker cp krb5:/etc/krb5.conf .
sed -i "s/kdc = $KRB5_DOMAIN/kdc = $KRB5_IP/" krb5.conf
sed -i "s/admin_server = $KRB5_DOMAIN/admin_server = $KRB5_IP/" krb5.conf
for i in "${all_pods[@]}"; do
  docker cp ./krb5.conf $i:/etc/krb5.conf
done

# 2. create principal and configure hdfs & hive
bash configure-build.sh

#!/bin/bash

hdfs_pods=(namenode datanode resourcemanager nodemanager historyserver)
hive_pods=(hive-metastore hive-server) # hive-presto
all_pods=("${hdfs_pods[@]}" "${hive_pods[@]}")

# 1. add krb5 principal and generate keytab
docker exec krb5 kadmin.local add_principal -randkey hdfs/$KRB5_DOMAIN@$KRB5_REALM
docker exec krb5 kadmin.local xst -k /hdfs.keytab hdfs/$KRB5_DOMAIN@$KRB5_REALM
docker exec krb5 kadmin.local add_principal -randkey HTTP/$KRB5_DOMAIN@$KRB5_REALM
docker exec krb5 kadmin.local xst -k /hdfs.keytab HTTP/$KRB5_DOMAIN@$KRB5_REALM
docker exec krb5 kadmin.local add_principal -randkey hive/$KRB5_DOMAIN@$KRB5_REALM
docker exec krb5 kadmin.local xst -k /hive.keytab hive/$KRB5_DOMAIN@$KRB5_REALM

docker cp krb5:/hdfs.keytab .
for i in "${hdfs_pods[@]}"; do
    docker cp ./hdfs.keytab $i:/etc/hdfs.keytab
    docker exec $i bash -c 'chmod 400 /etc/hdfs.keytab && ls -lah /etc/hdfs.keytab'
done

docker cp krb5:/hive.keytab .
for i in "${hive_pods[@]}"; do
    docker cp ./hive.keytab $i:/etc/hive.keytab
    docker exec $i /bin/bash -c 'chmod 400 /etc/hive.keytab && ls -lah /etc/hive.keytab'
done

# 2. config krb5 for all
for i in "${hdfs_pods[@]}"; do
  docker cp ./krb5-cfg-hdfs.sh $i:/
  docker exec $i /bin/bash /krb5-cfg-hdfs.sh
done

for i in "${hive_pods[@]}"; do
  docker cp ./krb5-cfg-hive.sh $i:/
  docker exec $i /bin/bash /krb5-cfg-hive.sh
done

# docker-compose restart
docker restart "${all_pods[@]}"

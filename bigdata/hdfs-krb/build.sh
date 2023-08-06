#!/bin/bash

HADOOP_VERSION=$(grep HADOOP_VERSION version.conf | cut -f2 -d'=')
HIVE_VERSION=$(grep HIVE_VERSION version.conf | cut -f2 -d'=')

HADOOP_KRB_VERSION=$HADOOP_VERSION-krb
HIVE_KRB_VERSION=$HIVE_VERSION-krb

hdfs_pods=(namenode datanode resourcemanager nodemanager historyserver)
hive_pods=(hive-metastore hive-server) # hive-presto

for i in "${hdfs_pods[@]}"; do
    echo "build docker for $i"
    cp hdfs.Dockerfile Dockerfile
    sed -i "s/\${POD}/${i}/" Dockerfile
    sed -i "s/\${HADOOP_VERSION}/${HADOOP_VERSION}/" Dockerfile
    target="jerrywill/hadoop-$i:${HADOOP_KRB_VERSION}"
    docker build -t "$target" .
    rm Dockerfile
    docker push "$target"
done

for i in "${hive_pods[@]}"; do
    echo "build docker for $i"
    cp hive.Dockerfile Dockerfile
    sed -i "s/\${HIVE_VERSION}/${HIVE_VERSION}/" Dockerfile
    target="jerrywill/hive:${HIVE_KRB_VERSION}"
    docker build -t "$target" .
    rm Dockerfile
    docker push "$target"
done

#!/usr/bin/env bash

# scp ./ my_remote:/path/to/hdfs/
if [ -z $1 ]; then
  echo "need one arg to specify KRB5_IP"
  exit 1
fi

KRB5_IP=$1
KRB5_DOMAIN=$2
KRB5_REALM=$3
if [ -z $KRB5_DOMAIN ]; then KRB5_DOMAIN=my.domain; fi
# KRB5_REALM=$(echo $KRB5_DOMAIN | tr '[a-z]' '[A-Z]')
if [ -z $KRB5_REALM ]; then KRB5_REALM=MY.DOMAIN; fi

sed -i "s/\${HDFS_PRINCIPAL}/hdfs\/$KRB5_DOMAIN@$KRB5_REALM/" krb5-cfg-hdfs.sh
sed -i "s/\${HTTP_PRINCIPAL}/HTTP\/$KRB5_DOMAIN@$KRB5_REALM/" krb5-cfg-hdfs.sh
sed -i "s/\${HIVE_PRINCIPAL}/hive\/$KRB5_DOMAIN@$KRB5_REALM/" krb5-cfg-hive.sh

HADOOP_VERSION=2.0.0-hadoop3.2.1-java8
HIVE_VERSION=2.3.2-postgresql-metastore
POSTGRESQL_VERSION=2.3.0
HBASE_VERSION=1.0.0-hbase1.2.6
PRESTODB_VERSION=0.245.1
sed -i "s/\${HADOOP_VERSION}/$HADOOP_VERSION/g" docker-compose.yaml
sed -i "s/\${HIVE_VERSION}/$HIVE_VERSION/g" docker-compose.yaml
sed -i "s/\${POSTGRESQL_VERSION}/$POSTGRESQL_VERSION/g" docker-compose.yaml
sed -i "s/\${HBASE_VERSION}/$HBASE_VERSION/g" docker-compose.yaml
sed -i "s/\${PRESTODB_VERSION}/$PRESTODB_VERSION/g" docker-compose.yaml

PROJECT_NAME=hdfs
HDFS_NETWORK=$PROJECT_NAME
sed -i "s/\${HDFS_NETWORK}/$HDFS_NETWORK/g" docker-compose.yaml

docker network create $HDFS_NETWORK
docker volume create ${PROJECT_NAME}_hadoop_namenode
docker volume create ${PROJECT_NAME}_hadoop_datanode
docker volume create ${PROJECT_NAME}_hadoop_historyserver
docker volume create ${PROJECT_NAME}_hbase_data
docker volume create ${PROJECT_NAME}_hbase_zookeeper_data

docker-compose up -d

bash configure.sh $KRB5_IP $KRB5_DOMAIN $KRB5_REALM
# kinit -kt hdfs.keytab hdfs/my.domain@MY.DOMAIN
# kinit -kt hive.keytab hive/my.domain@MY.DOMAIN
bash check.sh $KRB5_DOMAIN

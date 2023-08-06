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
if [ -z $KRB5_REALM ]; then KRB5_REALM=$(echo $KRB5_DOMAIN | tr '[a-z]' '[A-Z]'); fi

sed -i "s/\${HDFS_PRINCIPAL}/hdfs\/$KRB5_DOMAIN@$KRB5_REALM/" krb5-cfg-hdfs.sh
sed -i "s/\${HTTP_PRINCIPAL}/HTTP\/$KRB5_DOMAIN@$KRB5_REALM/" krb5-cfg-hdfs.sh
sed -i "s/\${HIVE_PRINCIPAL}/hive\/$KRB5_DOMAIN@$KRB5_REALM/" krb5-cfg-hive.sh

REPO=bde2020
HADOOP_VERSION=$(grep HADOOP_VERSION version.conf | cut -f2 -d'=')
HIVE_VERSION=$(grep HIVE_VERSION version.conf | cut -f2 -d'=')
POSTGRESQL_VERSION=$(grep POSTGRESQL_VERSION version.conf | cut -f2 -d'=')
HBASE_VERSION=$(grep HBASE_VERSION version.conf | cut -f2 -d'=')
PRESTODB_VERSION=$(grep PRESTODB_VERSION version.conf | cut -f2 -d'=')

sed -i "s/\${HADOOP_VERSION}/$HADOOP_VERSION/" docker-compose.yaml
sed -i "s/\${HIVE_VERSION}/$HIVE_VERSION/" docker-compose.yaml
sed -i "s/\${POSTGRESQL_VERSION}/$POSTGRESQL_VERSION/" docker-compose.yaml
sed -i "s/\${HBASE_VERSION}/$HBASE_VERSION/" docker-compose.yaml
sed -i "s/\${PRESTODB_VERSION}/$PRESTODB_VERSION/" docker-compose.yaml
sed -i "s/\${REPO}/${REPO}/" docker-compose.yaml

PROJECT_NAME=hdfs
NETWORK=$PROJECT_NAME
sed -i "s/\${NETWORK}/$NETWORK/g" docker-compose.yaml

docker network create $NETWORK
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

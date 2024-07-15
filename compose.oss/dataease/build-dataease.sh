#!/usr/bin/env bash

# https://dataease.io/docs/v2/installation/offline_INSTL_and_UPG
# https://community.fit2cloud.com/#/products/dataease/downloads
DATAEASE_VERSION=v2.8.0
DATAEASE_HOME=dataease-offline-installer-$DATAEASE_VERSION-ce

tar xfv $DATAEASE_HOME.tar.gz
IMAGE_FILE=$DATAEASE_HOME/images/dataease:$DATAEASE_VERSION.tar.gz
echo "load docker image from $IMAGE_FILE"
docker load -i $IMAGE_FILE

docker tag registry.cn-qingdao.aliyuncs.com/dataease/dataease:$DATAEASE_VERSION jerrywill/dataease:$DATAEASE_VERSION
docker rmi registry.cn-qingdao.aliyuncs.com/dataease/dataease:$DATAEASE_VERSION
docker push jerrywill/dataease:$DATAEASE_VERSION

ETCD_IMG=registry.cn-qingdao.aliyuncs.com/dataease/etcd:3.5.10
docker pull $ETCD_IMG
docker tag $ETCD_IMG jerrywill/dataease-etcd:3.5.10
docker rmi $ETCD_IMG
docker push jerrywill/dataease-etcd:3.5.10

APISIX_IMG=registry.cn-qingdao.aliyuncs.com/dataease/apisix:3.6.0-debian
docker pull $APISIX_IMG
docker tag $APISIX_IMG jerrywill/dataease-apisix:3.6.0
docker rmi $APISIX_IMG
docker push jerrywill/dataease-apisix:3.6.0

APISIX_DASHBOARD_IMG=registry.cn-qingdao.aliyuncs.com/dataease/apisix-dashboard:3.0.1-alpine
docker pull $APISIX_DASHBOARD_IMG
docker tag $APISIX_DASHBOARD_IMG jerrywill/dataease-apisix-dashboard:3.0.1
docker rmi $APISIX_DASHBOARD_IMG
docker push jerrywill/dataease-apisix-dashboard:3.0.1

SYNC_TASK_IMG=registry.cn-qingdao.aliyuncs.com/dataease/dataease-sync-task:v2.8.0
docker pull $SYNC_TASK_IMG
docker tag $SYNC_TASK_IMG jerrywill/dataease-sync-task:v2.8.0
docker rmi $SYNC_TASK_IMG
docker push jerrywill/dataease-sync-task:v2.8.0

CHROMIUM_TAG=registry.cn-qingdao.aliyuncs.com/dataease/standalone-chromium:123.0
docker pull $CHROMIUM_TAG
docker tag $CHROMIUM_TAG jerrywill/dataease-chromium:123.0
docker rmi $CHROMIUM_TAG
docker push jerrywill/dataease-chromium:123.0

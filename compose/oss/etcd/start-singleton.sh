#!/usr/bin/env bash

# https://hub.docker.com/r/bitnami/etcd

sudo chown -R "1001:$(id -g -n)" etcd

# /path/to/etcd.conf.yml:/opt/bitnami/Etcd/conf/etcd.conf.yml
docker run -itd --name etcd \
    --network dev \
    -p 2379:2379 \
    -p 2380:2380 \
    -e ALLOW_NONE_AUTHENTICATION=yes \
    -e ETCD_ADVERTISE_CLIENT_URLS=http://etcd:2379 \
    -v ./etcd:/bitnami/etcd/data \
    bitnami/etcd


cat <<EOF
docker run -it --rm \
    --network dev \
    -e ALLOW_NONE_AUTHENTICATION=yes \
    bitnami/etcd etcdctl --endpoints http://etcd:2379 put /message Hello
EOF


# https://github.com/evildecay/etcdkeeper
# http://127.0.0.1:8080/etcdkeeper etcd:2379
docker run -itd --name etcd-manager \
    --network dev \
    -p 8079:8080 \
    evildecay/etcdkeeper

#!/usr/bin/env bash

set -ex

# copy JDK to BE
docker run -itd --name starrocks-jdk-tmp jerrywill/jdk:17 bash


JDK_DIR=$(docker exec starrocks-jdk-tmp bash -c 'echo $JAVA_HOME | cut -d/ -f3')

if [[ -z "$JDK_DIR" ]]; then
  echo "failed to find JDK_DIR"
  exit 1
fi

docker cp starrocks-jdk-tmp:/opt/$JDK_DIR .

for i in starrocks-be1 starrocks-be2 starrocks-be3; do
    docker cp $JDK_DIR $i:/opt/
done
docker rm starrocks-jdk-tmp -f

cat <<EOF >> conf/be.conf
JAVA_HOME = "/opt/$JDK_DIR"
EOF

docker-compose restart be1 be2 be3

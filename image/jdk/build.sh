#!/usr/bin/env bash

NAMES[0]=zulu8.80.0.17-ca-jdk8.0.422-linux_x64
NAMES[1]=zulu11.74.15-ca-jdk11.0.24-linux_x64
NAMES[2]=zulu17.52.17-ca-jdk17.0.12-linux_x64

for NAME in ${NAMES[*]}; do
  VERSION=$(echo $NAME | grep -Eo 'jdk(\d+.0.\d+)-linux_x64' | grep -Eo '\d+.0.\d+')
  SHORT_VERSION=$(echo $VERSION | grep -Eo '^\d+')

  if [ `docker images | grep jerrywill/jdk | awk '{print $2}' | grep $SHORT_VERSION` ]; then
    echo -e "\033[32mjerrywill/jdk:$SHORT_VERSION already exists, skip it...\033[0m"
    continue
  fi

  JDK_DIR=jdk$VERSION
  tar xfvz $NAME.tar.gz || continue
  mv $NAME $JDK_DIR || continue
  tar cfvz $JDK_DIR.tar.gz $JDK_DIR/ || continue
  docker build -f $SHORT_VERSION.Dockerfile -t jerrywill/jdk:$SHORT_VERSION .
  rm -rf "jdk$VERSION" "jdk$VERSION.tar.gz"
done

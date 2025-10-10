#!/usr/bin/env bash

NAME=StarRocks-3.2.11-ubuntu-amd64
VERSION=$(echo $NAME | grep -Eo '[0-9]+.[0-9]+')
FE_VERSION=$VERSION-fe
BE_VERSION=$VERSION-be
CN_VERSION=$VERSION-cn

if [ -f $NAME.tar.gz ]; then
  tar xfvz $NAME.tar.gz
  mv $NAME starrocks
  tar cfvz fe.gz starrocks/fe
  tar cfvz be.gz starrocks/be
  rm -rf starrocks
fi

if [ `docker images | grep jerrywill/starrocks | awk '{print $2}' | grep $FE_VERSION` ]; then
  echo -e "\033[32mjerrywill/starrocks:$FE_VERSION already exists, skip it...\033[0m"
else
  mv fe.gz fe.tgz
  docker build -f fe.Dockerfile -t jerrywill/starrocks:$FE_VERSION .
  mv fe.tgz fe.gz
fi

if [ `docker images | grep jerrywill/starrocks | awk '{print $2}' | grep $BE_VERSION` ]; then
  echo -e "\033[32mjerrywill/starrocks:$BE_VERSION already exists, skip it...\033[0m"
else
  mv be.gz be.tgz
  docker build -f be.Dockerfile -t jerrywill/starrocks:$BE_VERSION .
  mv be.tgz be.gz
fi

if [ `docker images | grep jerrywill/starrocks | awk '{print $2}' | grep $CN_VERSION` ]; then
  echo -e "\033[32mjerrywill/starrocks:$CN_VERSION already exists, skip it...\033[0m"
else
  cat <<EOF > cn.Dockerfile
FROM jerrywill/starrocks:$BE_VERSION

CMD \${STARROCKS_HOME}/bin/start_cn.sh
EOF
  docker build -f cn.Dockerfile -t jerrywill/starrocks:$CN_VERSION .
  rm cn.Dockerfile
fi

#!/usr/bin/env bash

cd `dirname $0`
echo "work on `pwd`"

docker build -t tukeof/hbase .

docker tag tukeof/hbase tukeof/hbase:2
docker tag tukeof/hbase tukeof/hbase:2.1.3

cat <<EOF > /dev/null
# deploy
docker run -it -d --name hbase \
    -p 16010:16010 -p 16030:16030 \
    tukeof/hbase

# test on mac osx
open http://localhost:16010/master-status
open http://localhost:16030/rs-status
EOF

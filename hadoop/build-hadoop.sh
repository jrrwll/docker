#!/usr/bin/env bash

cd `dirname $0`
echo "work on `pwd`"

docker build -t tukeof/hadoop .

docker tag tukeof/hadoop tukeof/hadoop:3
docker tag tukeof/hadoop tukeof/hadoop:3.1.1

cat <<EOF > /dev/null
docker run --name had -it -d \
    -p 50070:50070 -p 8088:8088 -p 19888:19888 \
   tukeof/hadoop
EOF

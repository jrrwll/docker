#!/usr/bin/env bash

cd "$(dirname $0)" || return 1

# podman need the prefix: docker.io
repo=docker.io/jerrywill

for i in 8 9 10 11; do
  docker build -t $repo/debian:$i -f $i.Dockerfile .
  docker push $repo/debian:$i
done

docker tag $repo/debian:11 $repo/debian
docker push $repo/debian

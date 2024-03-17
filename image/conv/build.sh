#!/usr/bin/env bash

cd "$(dirname $0)" || return 1

# podman need the prefix: docker.io
repo=docker.io/jerrywill

ls | while read i; do
  [[ ! -f $i/Dockerfile ]] && continue
  docker build -t $repo/$i $i
  docker push $repo/$i
done

#!/usr/bin/env bash

for i in 8 9 10 11 12; do
  docker buildx build --platform linux/amd64,linux/arm64 --push \
    -t jerrywill/debian:$i -f $i.Dockerfile .

  echo "\nMaybe you want to push your mirror image next:"
  echo "docker push jerrywill/debian:$i"
done

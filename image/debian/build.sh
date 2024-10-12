#!/usr/bin/env bash

for i in 8 9 10 11 12; do
  docker build -t jerrywill/debian:$i -f $i.Dockerfile .
  docker push jerrywill/debian:$i
done

#!/usr/bin/env bash

docker run -it --rm --network dev \
  zookeeper zkCli.sh -server zookeeper

# ls /

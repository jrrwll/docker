#!/usr/bin/env bash

docker_build jerrywill/openjdk:8 openjdk/ 8.Dcokerfile
docker_build jerrywill/nexus nexus/
docker_build jerrywill/kafka kafka/






#!/usr/bin/env bash

docker-compose -p citus up --scale worker=3

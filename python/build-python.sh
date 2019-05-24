#!/usr/bin/env bash

cd `dirname $0`

docker build -t tukeof/python -f Dockerfile .

docker tag tukeof/python tukeof/python:3.7.3


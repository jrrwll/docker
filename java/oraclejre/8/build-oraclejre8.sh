#!/usr/bin/env bash

cd `dirname $0`

docker build -t bobbystrange/oraclejre .
docker tag bobbystrange/oraclejre bobbystrange/oraclejre:8
docker tag bobbystrange/oraclejre bobbystrange/oraclejre:1.8
docker tag bobbystrange/oraclejre bobbystrange/oraclejre:1.8.0_261

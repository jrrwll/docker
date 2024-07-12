#!/usr/bin/env bash

root_dir="$(cd `dirname $0` && cd .. && pwd -P)"

scp -r $root_dir/compose.oss/dataease dev:/home/tuke/docker/
scp -r $root_dir/compose/dev  dev:/home/tuke/docker/

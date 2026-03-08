#!/usr/bin/env bash

docker network ls | awk '{print $2}' | tail -n +2 | while read i; do
    subnet=$(docker network inspect "$i" | grep Subnet | cut -d '"' -f4)
    printf "%-19s: %s\n" "$subnet" "$i"
done

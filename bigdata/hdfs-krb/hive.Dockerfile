FROM bde2020/hive:${HIVE_VERSION}

MAINTAINER "tuke tukeof@gmail.com"

LABEL description="base on docker-hadoop & docker-hive in https://github.com/big-data-europe"

COPY debian8-jessie-sources.list.txtv /etc/apt/sources.list

RUN cat /etc/apt/sources.list \
    && apt-get update --force-yes \
    && apt-get install krb5-user -y --force-yes

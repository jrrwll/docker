FROM bde2020/hadoop-${POD}:${HADOOP_VERSION}

MAINTAINER "tuke tukeof@gmail.com"

LABEL description="base on docker-hadoop & docker-hive in https://github.com/big-data-europe"

COPY debian9-stretch-sources.list.txt /etc/apt/sources.list

RUN cat /etc/apt/sources.list \
    && apt-get update --force-yes \
    && apt-get install krb5-user -y --force-yes

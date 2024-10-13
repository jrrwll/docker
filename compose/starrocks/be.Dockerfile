FROM jerrywill/jdk:11

MAINTAINER "tuke tukeof@gmail.com"

ADD be.tgz /opt

RUN apt-get update && apt-get install procps net-tools libc6 -y --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# be be_http_port brpc_port
EXPOSE 8040
EXPOSE 8060

ENV STARROCKS_HOME=/opt/starrocks/be

WORKDIR ${STARROCKS_HOME}

#CMD ${STARROCKS_HOME}/bin/start_cn.sh
CMD ${STARROCKS_HOME}/bin/start_be.sh

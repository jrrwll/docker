FROM jerrywill/jdk:11

MAINTAINER "tuke tukeof@gmail.com"

ADD fe.tgz /opt

RUN apt-get update && apt-get install procps net-tools -y --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# fe http_port query_port
EXPOSE 8030
EXPOSE 9030

ENV STARROCKS_HOME=/opt/starrocks/fe

WORKDIR ${STARROCKS_HOME}

CMD ${STARROCKS_HOME}/bin/start_fe.sh

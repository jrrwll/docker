FROM jerrywill/jdk:11

MAINTAINER "tuke tukeof@gmail.com"

ADD be.tgz /opt

RUN apt-get update && apt-get install procps libc6 -y --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# be be_http_port
EXPOSE 8040

ENV STARROCKS_HOME=/opt/starrocks

WORKDIR ${STARROCKS_HOME}/be

#CMD ${STARROCKS_HOME}/be/bin/start_cn.sh
CMD ${STARROCKS_HOME}/be/bin/start_be.sh

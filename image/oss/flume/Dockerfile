FROM jerrywill/oraclejre:8

MAINTAINER "tuke tukeof@gmail.com"

# https://flume.apache.org/download.html
# https://dlcdn.apache.org/flume/1.11.0/apache-flume-1.11.0-bin.tar.gz
ENV FLUME_VERSION=1.11.0

ADD https://mirrors.aliyun.com/apache/flume/$FLUME_VERSION/apache-flume-$FLUME_VERSION-bin.tar.gz /opt/flume/

ENV FLUME_CONF_DIR=/opt/flume/conf
ENV FLUME_AGENT_NAME=flume1

EXPOSE 8080

ENTRYPOINT /opt/flume/bin/flume-ng agent -c ${FLUME_CONF_DIR} -f ${FLUME_CONF_DIR}/flume.conf \
    -n ${FLUME_AGENT_NAME} \
    -Dflume.monitoring.type=http -Dflume.monitoring.port=8080

FROM tukeof/oraclejre

MAINTAINER "tuke tukeof@gmail.com"

ENV HBASE_VERSION=2.1.3
ENV HBASE_HOME=/usr/local/hbase-${HBASE_VERSION}

# wget http://mirrors.hust.edu.cn/apache/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz
ADD hbase-$HBASE_VERSION-bin.tar.gz /usr/local
COPY hbase-site.xml ${HBASE_HOME}/conf/hbase-site.xml

WORKDIR ${HBASE_HOME}

EXPOSE 16010
EXPOSE 16030

CMD ln -s ${HBASE_HOME}/bin/* /usr/local/bin/ && \
    ${HBASE_HOME}/bin/start-hbase.sh && \
    bash


FROM jerrywill/debian:9

MAINTAINER "tuke tukeof@gmail.com"

ENV JAVA_MINOR_VERSION=411
ENV JAVA_VERSION=1.8.0_$JAVA_MINOR_VERSION

ENV JAVA_HOME=/usr/local/jre${JAVA_VERSION}

# https://www.java.com/en/download/manual.jsp Linux x64
ADD jre-8u${JAVA_MINOR_VERSION}-linux-x64.tar.gz /usr/local

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}


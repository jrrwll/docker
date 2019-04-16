FROM debian

LABEL maintainer="tukeof@gmail.com" \
      version="1.0" \
      description="oracle jre image"

ENV JDK_VERSION=1.8.0_201
ENV JAVA_HOME=/usr/local/jre${JDK_VERSION}

ADD jre-8u201-linux-x64.tar.gz /usr/local

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

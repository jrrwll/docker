FROM debian

MAINTAINER "tuke tukeof@gmail.com"

ENV JDK_VERSION=1.8.0_211
ENV JAVA_HOME=/usr/local/jdk${JDK_VERSION}

ADD jdk-8u211-linux-x64.tar.gz /usr/local

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

FROM tukeof/debian

MAINTAINER "tuke tukeof@gmail.com"

ENV JDK_VERSION=1.8.0_241
ENV JAVA_HOME=/usr/local/jdk${JDK_VERSION}

ADD jdk-8u241-linux-x64.tar.gz /usr/local

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

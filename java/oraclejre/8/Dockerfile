FROM debian

MAINTAINER "tuke bobby.j.strange@gmail.com"

ENV JDK_VERSION=1.8.0_271
ENV JAVA_HOME=/usr/local/jre${JDK_VERSION}

ADD jre-8u271-linux-x64.tar.gz /usr/local

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

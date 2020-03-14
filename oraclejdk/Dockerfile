FROM tukeof/debian

MAINTAINER "tuke tukeof@gmail.com"

RUN apt-get update -y && apt-get install -y libfreetype6 fontconfig && \
    fc-cache --force && \
    apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && apt-get purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV JDK_VERSION=13.0.2

ENV JAVA_HOME=/usr/local/jdk-${JDK_VERSION}

ADD jdk-${JDK_VERSION}_linux-x64_bin.tar.gz /usr/local

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

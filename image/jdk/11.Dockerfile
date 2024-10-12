FROM jerrywill/debian:12

MAINTAINER "tuke tukeof@gmail.com"

# https://www.azul.com/downloads/?version=java-11-lts&os=linux&package=jdk#zulu

ENV JAVA_HOME=/opt/jdk11.0.24

ADD jdk11.0.24.tar.gz /opt

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

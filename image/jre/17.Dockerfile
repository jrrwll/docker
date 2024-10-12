FROM jerrywill/debian:11

MAINTAINER "tuke tukeof@gmail.com"

# https://www.azul.com/downloads/?version=java-17-lts&os=linux&package=jre#zulu

ENV JAVA_HOME=/usr/local/jre17.0.11

ADD jre17.0.11.tar.gz /usr/local

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

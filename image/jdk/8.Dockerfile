FROM jerrywill/debian:12

MAINTAINER "tuke tukeof@gmail.com"

# https://www.azul.com/downloads/?version=java-17-lts&os=linux&package=jdk#zulu

ENV JAVA_HOME=/opt/jdk8.0.422

ADD jdk8.0.422.tar.gz /opt

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

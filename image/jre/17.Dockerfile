FROM jerrywill/debian:12

LABEL maintainer="tuke tukeof@gmail.com"

# https://www.azul.com/downloads/?version=java-17-lts&os=linux&package=jre#zulu

ENV JAVA_HOME=/usr/local/jre17.0.16

ADD jre17.0.16.tar.gz /usr/local

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

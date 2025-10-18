FROM jerrywill/debian:12

LABEL maintainer="tuke tukeof@gmail.com"

# https://www.azul.com/downloads/?version=java-21-lts&os=linux&package=jre#zulu

ENV JAVA_HOME=/usr/local/jre21.0.8

ADD jre21.0.8.tar.gz /usr/local

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

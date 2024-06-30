FROM jerrywill/debian:11

MAINTAINER "tuke tukeof@gmail.com"

ENV JAVA_HOME=/usr/local/zulu17.50.19-ca-jre17.0.11-linux_x64

# https://www.azul.com/downloads/?version=java-17-lts&os=linux&package=jre#zulu
ADD zulu17.50.19-ca-jre17.0.11-linux_x64.tar.gz /usr/local
# tar zxfv some.tar.gz -C /path/to/decompress

RUN ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

# docker build -t . jerrywill/jre:17

FROM jerrywill/debian:11

MAINTAINER "tuke tukeof@gmail.com"

ENV JAVA_HOME=/usr/local/jre17.0.11

# https://www.azul.com/downloads/?version=java-17-lts&os=linux&package=jre#zulu
ADD zulu17.50.19-ca-jre17.0.11-linux_x64.tar.gz /usr/local
# tar zxfv some.tar.gz -C /path/to/decompress

RUN mv /usr/local/zulu17.50.19-ca-jre17.0.11-linux_x64 /usr/local/jre17.0.11 && \
    ln -s ${JAVA_HOME}/bin/* /usr/local/bin/

WORKDIR ${JAVA_HOME}

# docker build -f 17.Dockerfile -t jerrywill/jre:17 .

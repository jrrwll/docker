FROM bobbystrange/oraclejre:8

MAINTAINER "tuke jrriwll@gmail.com"

# https://download.sonatype.com/nexus/3/latest-unix.tar.gz
ENV NEXUS_VERSION=3.34.1-01

# curl -sI https://download.sonatype.com/nexus/3/latest-unix.tar.gz | grep location | cut -d' ' -f2

#RUN mkdir -p /usr/local && cd /usr/local && \
#    wget https://sonatype-download.global.ssl.fastly.net/repository/repositoryManager/3/nexus-${NEXUS_VERSION}-unix.tar.gz && \
#    tar xfvz nexus-${NEXUS_VERSION}-unix.tar.gz && \
#    rm -f nexus-${NEXUS_VERSION}-unix.tar.gz

ADD latest-unix.tar.gz /usr/local

RUN ln -s /usr/local/nexus-${NEXUS_VERSION}/bin/nexus /usr/bin/nexus

WORKDIR /usr/local/nexus-${NEXUS_VERSION}

EXPOSE 8081

CMD nexus run

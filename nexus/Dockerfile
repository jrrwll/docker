FROM tukeof/fatopenjdk

MAINTAINER "tuke tukeof@gmail.com"

ENV NEXUS_VERSION=3.16.1-02

#RUN mkdir -p /usr/local && cd /usr/local && \
#    wget https://sonatype-download.global.ssl.fastly.net/repository/repositoryManager/3/nexus-${NEXUS_VERSION}-unix.tar.gz && \
#    tar xfvz nexus-${NEXUS_VERSION}-unix.tar.gz && \
#    rm -f nexus-${NEXUS_VERSION}-unix.tar.gz

ADD nexus-${NEXUS_VERSION}-unix.tar.gz /usr/local

RUN ln -s /usr/local/nexus-${NEXUS_VERSION}/bin/nexus /usr/bin/nexus

WORKDIR /usr/local/nexus-${NEXUS_VERSION}

EXPOSE 8081

CMD nexus run

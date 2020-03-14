FROM tukeof/debian

ENV SSDB_VERSION=1.9.5

RUN apt-get update -y && apt-get install -y wget make g++ unzip autoconf python && \
    wget --no-check-certificate https://github.com/ideawu/ssdb/archive/stable-${SSDB_VERSION}.zip && \
    unzip stable-${SSDB_VERSION}.zip && \
    cd ssdb-stable-${SSDB_VERSION} && \
    make && \
    make install && \
    cd .. && rm -rf ssdb-stable-${SSDB_VERSION} && rm -f stable-${SSDB_VERSION}.zip && \
    apt-get remove -y wget make g++ unzip autoconf && \
    apt-get autoremove -y && apt-get clean -y && apt-get autoclean -y && \
    sed -i '/export PATH/i PATH="\$PATH:/usr/local/ssdb"' /etc/profile

CMD /usr/local/ssdb/ssdb-server /usr/local/ssdb/ssdb.conf

#RUN yum install -y wget make gcc-c++ which && \
#    yum install autoconf unzip -y && \
#    wget --no-check-certificate https://github.com/ideawu/ssdb/archive/master.zip && \
#    unzip master.zip && \
#    cd ssdb-master && \
#    make && \
#    make install && \
#    cd .. && rm -rf ssdb-master && rm -f master.zip && \
#    yum remove unzip autoconf -y && \
#    yum remove wget make gcc-c++ which -y && \
#    yum clean all && rm -rf /tmp && \
#    sed -i '/export PATH/i PATH="\$PATH:/usr/local/ssdb"' /etc/profile

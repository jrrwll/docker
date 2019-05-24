FROM centos

RUN yum install -y wget make gcc-c++ which && \
    yum install autoconf unzip -y && \
    wget --no-check-certificate https://github.com/ideawu/ssdb/archive/master.zip && \
    unzip master.zip && \
    cd ssdb-master && \
    make && \
    make install && \
    cd .. && rm -rf ssdb-master && rm -f master.zip && \
    yum remove unzip autoconf -y && \
    yum remove wget make gcc-c++ which -y && \
    yum clean all && rm -rf /tmp && \
    sed -i '/export PATH/i PATH="\$PATH:/usr/local/ssdb"' /etc/profile

CMD /usr/local/ssdb/ssdb-server /usr/local/ssdb/ssdb.conf

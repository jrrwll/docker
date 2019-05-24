FROM debian

RUN apt-get update -y && apt-get install -y wget make g++ unzip autoconf python && \
    wget --no-check-certificate https://github.com/ideawu/ssdb/archive/master.zip && \
    unzip master.zip && \
    cd ssdb-master && \
    make && \
    make install && \
    cd .. && rm -rf ssdb-master && rm -f master.zip && \
    apt-get remove -y wget make g++ unzip autoconf && \
    apt-get autoremove -y && apt-get clean -y && apt-get autoclean -y && \
    sed -i '/export PATH/i PATH="\$PATH:/usr/local/ssdb"' /etc/profile

CMD /usr/local/ssdb/ssdb-server /usr/local/ssdb/ssdb.conf


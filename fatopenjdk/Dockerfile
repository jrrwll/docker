FROM debian

MAINTAINER "tuke tukeof@gmail.com"

COPY sources.list /etc/apt/sources.list

# docker run --cap-add=SYS_PTRACE

# build in cmdss
# ===== ==== =====
# ===== ==== =====
# java, zip, unzip, ps, top, htop, nslookup, dig, wget, curl
RUN apt-get update -y && \
    apt-get install openjdk-8-jre-headless -y && \
    apt-get install zip unzip procps htop dnsutils wget curl -y && \
    apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && apt-get purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

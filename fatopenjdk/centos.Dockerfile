FROM centos

MAINTAINER "tuke tukeof@gmail.com"

# RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# build in cmdss
# ===== ==== =====
# vi, curl, ps, top,
# ===== ==== =====
# java, zip, unzip, nslookup, dig, wget
RUN yum install -y java-1.8.0-openjdk-headless fontconfig -y && \
    yum install -y zip unzip bind-utils wget && \
    wget dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm && \
    rpm -ihv epel-release-7-11.noarch.rpm && \
    rm -f epel-release-7-11.noarch.rpm && \
    yum install htop -y && \
    yum clean all -y


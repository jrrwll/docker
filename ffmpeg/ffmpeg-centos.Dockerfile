FROM centos

LABEL maintainer="tukeof@gmail.com" \
      version="1.0" \
      description="ffmpeg image based on centos"

RUN yum install -y epel-release && \
    rpm -v --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro && \
    rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    yum install -y ffmpeg ffmpeg-devel

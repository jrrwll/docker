FROM centos

LABEL maintainer="tukeof@gmail.com" \
      version="1.0" \
      description="gcc image based on centos"

RUN yum install -y poppler-utils wget make gcc-c++


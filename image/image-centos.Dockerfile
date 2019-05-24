FROM centos

MAINTAINER "tukeof@gmail.com"

RUN yum install epel-release -y && \
    yum install -y GraphicsMagick ImageMagick

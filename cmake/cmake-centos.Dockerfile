FROM centos

MAINTAINER "tuke tukeof@gmail.com"

ENV CMAKE_VERSION=3.14.3

RUN yum install -y wget unzip make gcc-c++ which

RUN mkdir -p /tmp && cd /tmp && \
    wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION.tar.gz && \
    tar xfz cmake-$CMAKE_VERSION.tar.gz && \
    cd cmake-$CMAKE_VERSION && \
    ./configure && \
    make && make install && \
    cd .. && rm -rf cmake-$CMAKE_VERSION



FROM tukeof/debian

MAINTAINER "tuke tukeof@gmail.com"

RUN apt-get update -y && \
    apt-get install -y apt-utils wget unzip autoconf make g++ cmake

#RUN yum makecache && yum install -y wget unzip make gcc-c++ which cmake
##
##ENV CMAKE_VERSION=3.16.5
##
##RUN mkdir -p /tmp && cd /tmp && \
##    wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION.tar.gz && \
##    tar xfz cmake-$CMAKE_VERSION.tar.gz && \
##    rm -rf cmake-$CMAKE_VERSION.tar.gz && \
##    cd cmake-$CMAKE_VERSION && \
##    yum install openssl-devel -y && \
##    ./configure && make && make install && \
##    cd .. && rm -rf cmake-$CMAKE_VERSION
##
##

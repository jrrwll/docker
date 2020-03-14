FROM tukeof/centos:7

MAINTAINER "tuke tukeof@gmail.com"

RUN yum -y install wget \
    && wget http://www.swftools.org/swftools-2013-04-09-1007.tar.gz \
    && tar -zxf swftools-2013-04-09-1007.tar.gz && cd swftools-2013-04-09-1007 \
    && yum -y install gcc gcc-c++ make zlib-devel libjpeg-turbo-devel freetype-devel giflib-devel
    && ./configure && make && make install \
    && cd .. && rm -rf swftools-2013-04-09-1007* \
    && yum -y remove wget gcc gcc-c++ make zlib-devel libjpeg-turbo-devel freetype-devel giflib-devel \
    && yum clean all

COPY xpdf-chinese-simplified /usr/local/share/xpdf-chinese-simplified

COPY libwebp-imageio.so /usr/lib/

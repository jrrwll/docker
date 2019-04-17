FROM centos

LABEL maintainer="tukeof@gmail.com" \
      version="1.0" \
      description="swftools image based on centos 7.4"

RUN yum -y install epel-release \
    && yum -y install gcc gcc-c++ make wget zlib-devel libjpeg-turbo-devel freetype-devel giflib-devel \
    && wget http://www.swftools.org/swftools-2013-04-09-1007.tar.gz \
    && tar -zxf swftools-2013-04-09-1007.tar.gz && cd swftools-2013-04-09-1007 \
    && ./configure && make && make install \
    && cd .. && rm -rf swftools-2013-04-09-1007* \
    && yum -y remove wget gcc gcc-c++

COPY xpdf-chinese-simplified /usr/local/share/xpdf-chinese-simplified

COPY libwebp-imageio.so /usr/lib/

FROM centos

MAINTAINER "tuke tukeof@gmail.com"

RUN yum install -y qpdf ghostscript

ENV MUPDF_VERSION=1.15.0
# yum whatprovides \*/gl.h
# yum whatprovides \*/glu.h
# yum whatprovides \*/XInput.h
# GL/gl.h                   mesa-libGL-devel
# GL/glu.h                  mesa-libGLU-devel
# X11/extensions/XInput.h   libXi-devel
# X11/extensions/Xrandr.h   libXrandr-devel
RUN yum install -y wget make gcc-c++ && \
    yum install -y mesa-libGL-devel mesa-libGLU-devel libXi-devel libXrandr-devel && \
    wget https://mupdf.com/downloads/archive/mupdf-${MUPDF_VERSION}-source.tar.gz && \
    tar xfz mupdf-${MUPDF_VERSION}-source.tar.gz && \
    rm -f mupdf-${MUPDF_VERSION}-source.tar.gz && \
    cd mupdf-${MUPDF_VERSION}-source && \
    make && make install && cd .. && rm -rf mupdf-${MUPDF_VERSION}-source && \
    yum remove -y mesa-libGL-devel mesa-libGLU-devel libXi-devel libXrandr-devel && \
    yum remove -y wget make gcc-c++ && \
    yum clean all

#ENV POPPLER_VERSION=0.77.0
# Could NOT find Freetype (missing: FREETYPE_LIBRARY FREETYPE_INCLUDE_DIRS)
#RUN yum install -y wget make gcc-c++ && \
#    mkdir -p /tmp && cd /tmp && \
#    CMAKE_VERSION=3.14.5  && \
#    wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION.tar.gz && \
#    tar xfz cmake-$CMAKE_VERSION.tar.gz && \
#    cd cmake-$CMAKE_VERSION && \
#    ./configure && make && \
#    yum install -y freetype-devel fontconfig-devel nss-devel libtiff-devel libjpeg-turbo-devel openjpeg-devel cairo-devel gtk3-devel && \
#    wget https://poppler.freedesktop.org/poppler-$POPPLER_VERSION.tar.xz && \
#    tar xf poppler-$POPPLER_VERSION.tar.xz && \
#    rm -f poppler-$POPPLER_VERSION.tar.xz && \
#    cd poppler-$POPPLER_VERSION && \
#    /tmp/cmake-$CMAKE_VERSION/bin/cmake . && make && make install && \
#    cd .. && rm -rf poppler-$POPPLER_VERSION && \
#    rm -rf /tmp/cmake-$CMAKE_VERSION && \
#    yum remove -y wget make gcc-c++ freetype-devel && \
#    yum clean all
#
#    wget https://github.com/uclouvain/openjpeg/archive/v2.3.1.tar.gz && \
#    tar xf v2.3.1.tar.gz && \
#    rm -rf v2.3.1.tar.gz && \
#    cd openjpeg-2.3.1/ && \
#    cmake . && make && make install
#    cp -rf bin/ /usr/local/bin/ && \
#    cp -rf lib/ /usr/local/lib/ && \
#    cp -rf include/ /usr/local/include/ && \
#

RUN yum install poppler-utils -y

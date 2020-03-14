FROM tukeof/debian

MAINTAINER "tuke tukeof@gmail.com"

RUN apt-get update -y && \
    apt-get install -y apt-utils qpdf ghostscript poppler-utils mupdf-tools && \
    apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && apt-get purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN apt-get update -y && \
#    apt-get install -y apt-utils qpdf ghostscript && \
#    apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && apt-get purge -y && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#
#ENV MUPDF_VERSION=1.16.1
## mutool
## https://mupdf.com/downloads/archive/mupdf-1.15.0-source.tar.xz
## apt-get install apt-file && apt-file update && apt-file search "GL/gl.h"
## GL/gl.h                   mesa-common-dev
## GL/glu.h                  libglu1-mesa-dev
## X11/extensions/XInput.h   libxi-dev
## X11/extensions/Xrandr.h   libxrandr-dev
#RUN apt-get update -y && \
#    apt-get install -y wget make g++ xz-utils && \
#    echo "compiling mutool" && \
#    apt-get install -y mesa-common-dev libglu1-mesa-dev libxi-dev libxrandr-dev && \
#    wget https://mupdf.com/downloads/archive/mupdf-${MUPDF_VERSION}-source.tar.gz && \
#    tar xf mupdf-${MUPDF_VERSION}-source.tar.gz && \
#    rm -f mupdf-${MUPDF_VERSION}-source.tar.gz && \
#    cd mupdf-${MUPDF_VERSION}-source && \
#    make && make install && cd .. && rm -rf mupdf-${MUPDF_VERSION}-source && \
#    apt-get remove -y wget make g++ cmake && \
#    apt-get remove -y mesa-common-dev libglu1-mesa-dev libxi-dev libxrandr-dev && \
#    apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && apt-get purge -y && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#
#ENV POPPLER_VERSION=0.86.1
## poppler
## FREETYPE_LIBRARY          libfreetype6-dev
## FONTCONFIG_LIBRARIES      libfontconfig1-dev
## JPEG_LIBRARY              libjpeg-dev
## TIFF_LIBRARY              libtiff5-dev
## NSS3_LIBRARIES            libnss3-dev
##               Qt5Core, Qt5Gui, Qt5Xml, Qt5Widgets, Qt5Test
##               libqt5core5a libqt5gui5 libqt5widgets5 libqt5xml5
## OpenJPEG                  libopenjp2-7-dev
#RUN apt-get -y update && apt-get install -y wget make g++ xz-utils cmake && \
#    echo "compiling poppler" && \
#    apt-get install -y libfreetype6-dev libfontconfig1-dev libjpeg-dev libtiff5-dev libnss3-dev libopenjp2-7-dev && \
#    wget https://poppler.freedesktop.org/poppler-$POPPLER_VERSION.tar.xz && \
#    tar xf poppler-$POPPLER_VERSION.tar.xz && \
#    rm -f poppler-$POPPLER_VERSION.tar.xz && \
#    cd poppler-$POPPLER_VERSION && \
#    cmake . && make && make install && \
#    cd .. && rm -rf poppler-$POPPLER_VERSION && \
#    apt-get remove -y wget make g++ cmake && \
#    apt-get remove -y libfreetype6-dev libfontconfig1-dev libjpeg-dev libtiff5-dev libnss3-dev libopenjp2-7-dev && \
#    apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && apt-get purge -y && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


## centos
#ENV MUPDF_VERSION=1.16.1
## yum whatprovides \*/gl.h
## yum whatprovides \*/glu.h
## yum whatprovides \*/XInput.h
## GL/gl.h                   mesa-libGL-devel
## GL/glu.h                  mesa-libGLU-devel
## X11/extensions/XInput.h   libXi-devel
## X11/extensions/Xrandr.h   libXrandr-devel
#RUN yum install -y wget make gcc-c++ && \
#    yum install -y mesa-libGL-devel mesa-libGLU-devel libXi-devel libXrandr-devel && \
#    wget https://mupdf.com/downloads/archive/mupdf-${MUPDF_VERSION}-source.tar.gz && \
#    tar xfz mupdf-${MUPDF_VERSION}-source.tar.gz && \
#    rm -f mupdf-${MUPDF_VERSION}-source.tar.gz && \
#    cd mupdf-${MUPDF_VERSION}-source && \
#    make && make install && cd .. && rm -rf mupdf-${MUPDF_VERSION}-source && \
#    yum remove -y mesa-libGL-devel mesa-libGLU-devel libXi-devel libXrandr-devel && \
#    yum remove -y wget make gcc-c++ && \
#    yum clean all
#
##ENV POPPLER_VERSION=0.86.1
## Could NOT find Freetype (missing: FREETYPE_LIBRARY FREETYPE_INCLUDE_DIRS)
##RUN yum install -y wget make gcc-c++ && \
##    mkdir -p /tmp && cd /tmp && \
##    CMAKE_VERSION=3.14.5  && \
##    wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION.tar.gz && \
##    tar xfz cmake-$CMAKE_VERSION.tar.gz && \
##    cd cmake-$CMAKE_VERSION && \
##    ./configure && make && \
##    yum install -y freetype-devel fontconfig-devel nss-devel libtiff-devel libjpeg-turbo-devel openjpeg-devel cairo-devel gtk3-devel && \
##    wget https://poppler.freedesktop.org/poppler-$POPPLER_VERSION.tar.xz && \
##    tar xf poppler-$POPPLER_VERSION.tar.xz && \
##    rm -f poppler-$POPPLER_VERSION.tar.xz && \
##    cd poppler-$POPPLER_VERSION && \
##    /tmp/cmake-$CMAKE_VERSION/bin/cmake . && make && make install && \
##    cd .. && rm -rf poppler-$POPPLER_VERSION && \
##    rm -rf /tmp/cmake-$CMAKE_VERSION && \
##    yum remove -y wget make gcc-c++ freetype-devel && \
##    yum clean all
##
##    wget https://github.com/uclouvain/openjpeg/archive/v2.3.1.tar.gz && \
##    tar xf v2.3.1.tar.gz && \
##    rm -rf v2.3.1.tar.gz && \
##    cd openjpeg-2.3.1/ && \
##    cmake . && make && make install
##    cp -rf bin/ /usr/local/bin/ && \
##    cp -rf lib/ /usr/local/lib/ && \
##    cp -rf include/ /usr/local/include/ && \

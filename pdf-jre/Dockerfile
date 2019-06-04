FROM tukeof/oraclejre

MAINTAINER "tuke tukeof@gmail.com"

RUN apt-get update -y && \
    apt-get install -y apt-utils qpdf ghostscript && \
    apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && apt-get purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV MUPDF_VERSION=1.15.0
# mutool
# https://mupdf.com/downloads/archive/mupdf-1.15.0-source.tar.xz
# apt-get install apt-file && apt-file update && apt-file search "GL/gl.h"
# GL/gl.h                   mesa-common-dev
# GL/glu.h                  libglu1-mesa-dev
# X11/extensions/XInput.h   libxi-dev
# X11/extensions/Xrandr.h   libxrandr-dev
RUN apt-get update -y && \
    apt-get install -y wget make g++ xz-utils && \
    echo "compiling mutool" && \
    apt-get install -y mesa-common-dev libglu1-mesa-dev libxi-dev libxrandr-dev && \
    wget https://mupdf.com/downloads/archive/mupdf-${MUPDF_VERSION}-source.tar.gz && \
    tar xf mupdf-${MUPDF_VERSION}-source.tar.gz && \
    rm -f mupdf-${MUPDF_VERSION}-source.tar.gz && \
    cd mupdf-${MUPDF_VERSION}-source && \
    make && make install && cd .. && rm -rf mupdf-${MUPDF_VERSION}-source && \
    apt-get remove -y wget make g++ cmake && \
    apt-get remove -y mesa-common-dev libglu1-mesa-dev libxi-dev libxrandr-dev && \
    apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && apt-get purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV POPPLER_VERSION=0.77.0
# poppler
# FREETYPE_LIBRARY          libfreetype6-dev
# FONTCONFIG_LIBRARIES      libfontconfig1-dev
# JPEG_LIBRARY              libjpeg-dev
# TIFF_LIBRARY              libtiff5-dev
# NSS3_LIBRARIES            libnss3-dev
#               Qt5Core, Qt5Gui, Qt5Xml, Qt5Widgets, Qt5Test
#               libqt5core5a libqt5gui5 libqt5widgets5 libqt5xml5
# OpenJPEG                  libopenjp2-7-dev
RUN apt-get -y update && apt-get install -y wget make g++ xz-utils cmake && \
    echo "compiling poppler" && \
    apt-get install -y libfreetype6-dev libfontconfig1-dev libjpeg-dev libtiff5-dev libnss3-dev libopenjp2-7-dev && \
    wget https://poppler.freedesktop.org/poppler-$POPPLER_VERSION.tar.xz && \
    tar xf poppler-$POPPLER_VERSION.tar.xz && \
    rm -f poppler-$POPPLER_VERSION.tar.xz && \
    cd poppler-$POPPLER_VERSION && \
    cmake . && make && make install && \
    cd .. && rm -rf poppler-$POPPLER_VERSION && \
    apt-get remove -y wget make g++ cmake && \
    apt-get remove -y libfreetype6-dev libfontconfig1-dev libjpeg-dev libtiff5-dev libnss3-dev libopenjp2-7-dev && \
    apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && apt-get purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM foekut/oraclejre

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

RUN yum install poppler-utils -y

FROM tukeof/cmake

LABEL maintainer="tukeof@gmail.com" \
      version="1.0" \
      description="pdf image based on centos"

ENV MUPDF_VERSION=1.14.0

# yum whatprovides \*/gl.h
# yum whatprovides \*/glu.h
# yum whatprovides \*/XInput.h

# GL/gl.h                   mesa-libGL-devel
# GL/glu.h                  mesa-libGLU-devel
# X11/extensions/XInput.h   libXi-devel
# X11/extensions/Xrandr.h   libXrandr-devel
RUN yum install -y mesa-libGL-devel mesa-libGLU-devel libXi-devel libXrandr-devel && \
    wget https://mupdf.com/downloads/archive/mupdf-${MUPDF_VERSION}-source.tar.gz && \
    tar xfz mupdf-${MUPDF_VERSION}-source.tar.gz && \
    rm -f mupdf-${MUPDF_VERSION}-source.tar.gz && \
    cd mupdf-${MUPDF_VERSION}-source && \
    make && make install && cd .. && rm -rf mupdf-${MUPDF_VERSION}-source && \
    yum remove -y mesa-libGL-devel mesa-libGLU-devel libXi-devel libXrandr-devel && \

ENV POPPLER_VERSION=0.76.1
# Could NOT find Freetype (missing: FREETYPE_LIBRARY FREETYPE_INCLUDE_DIRS)
RUN yum install -y freetype-devel  && \
    wget https://poppler.freedesktop.org/poppler-$POPPLER_VERSION.tar.xz && \
    tar xfz poppler-$POPPLER_VERSION.tar.xz && \
    rm -f poppler-$POPPLER_VERSION.tar.xz && \
    cd poppler-$POPPLER_VERSION && \
    cmake . && make && make install && \
    cd .. && rm -rf poppler-$POPPLER_VERSION && \
    yum remove -y wget make gcc-c++

RUN yum install freetype-devel -y && \

RUN yum install -y qpdf ghostscript

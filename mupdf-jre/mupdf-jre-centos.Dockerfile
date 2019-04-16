FROM tukeof/oraclejre-centos

LABEL maintainer="tukeof@gmail.com" \
      version="1.0" \
      description="mupdf image with jre based on centos"

ENV MUPDF_VERSION=1.14.0

# yum whatprovides \*/gl.h
# yum whatprovides \*/glu.h
# yum whatprovides \*/XInput.h

# GL/gl.h                   mesa-libGL-devel
# GL/glu.h                  mesa-libGLU-devel
# X11/extensions/XInput.h   libXi-devel
# X11/extensions/Xrandr.h   libXrandr-devel
RUN yum install -y ghostscript poppler-utils wget make gcc-c++ && \
    yum install -y mesa-libGL-devel mesa-libGLU-devel libXi-devel libXrandr-devel && \
    wget https://mupdf.com/downloads/archive/mupdf-${MUPDF_VERSION}-source.tar.gz && \
    tar xfz mupdf-${MUPDF_VERSION}-source.tar.gz && \
    rm -f mupdf-${MUPDF_VERSION}-source.tar.gz && \
    cd mupdf-${MUPDF_VERSION}-source && \
    make && make install && cd .. && rm -rf mupdf-${MUPDF_VERSION}-source && \
    yum remove -y wget make gcc-c++ && \
    yum remove -y mesa-libGL-devel mesa-libGLU-devel libXi-devel libXrandr-devel


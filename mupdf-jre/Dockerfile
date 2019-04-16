FROM tukeof/oraclejre

LABEL maintainer="tukeof@gmail.com" \
      version="1.0" \
      description="mupdf image with jre"

ENV MUPDF_VERSION=1.14.0

# apt-get install apt-file && apt-file update && apt-file search "GL/gl.h"
# GL/gl.h                   mesa-common-dev
# GL/glu.h                  libglu1-mesa-dev
# X11/extensions/XInput.h   libxi-dev
# X11/extensions/Xrandr.h   libxrandr-dev
RUN apt-get update -y && \
    apt-get install -y apt-utils ghostscript poppler-utils wget make g++ && \
    apt-get install -y mesa-common-dev libglu1-mesa-dev libxi-dev libxrandr-dev && \
    wget https://mupdf.com/downloads/archive/mupdf-${MUPDF_VERSION}-source.tar.gz && \
    tar xfz mupdf-${MUPDF_VERSION}-source.tar.gz && \
    rm -f mupdf-${MUPDF_VERSION}-source.tar.gz && \
    cd mupdf-${MUPDF_VERSION}-source && \
    make && make install && rm -rf ../mupdf-${MUPDF_VERSION}-source && \
    apt-get remove -y wget make g++ && \
    apt-get remove -y mesa-common-dev libglu1-mesa-dev libxi-dev libxrandr-dev && \
    apt-get autoremove -y

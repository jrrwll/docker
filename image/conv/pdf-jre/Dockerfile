FROM jerrywill/oraclejre

MAINTAINER "tuke tukeof@gmail.com"

RUN apt-get update -y && \
    apt-get install -y apt-utils imagemagick graphicsmagick && \
    apt-get install -y qpdf ghostscript poppler-utils mupdf-tools && \
    apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && apt-get purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

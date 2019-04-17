FROM centos

LABEL maintainer="tukeof@gmail.com" \
      version="1.0" \
      description="font image based on centos"

COPY docker-fonts /usr/share/fonts/stix

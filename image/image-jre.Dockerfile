FROM tukeof/oraclejre

MAINTAINER "tukeof@gmail.com"

RUN apt-get update -y && \
    apt-get install -y apt-utils imagemagick graphicsmagick


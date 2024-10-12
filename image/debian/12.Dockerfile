FROM debian:12

MAINTAINER "tuke tukeof@gmail.com"

COPY debian12-bookworm-sources.list.txt /etc/apt/sources.list

RUN rm /etc/apt/sources.list.d/debian.sources

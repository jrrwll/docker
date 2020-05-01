FROM nginx

MAINTAINER "tuke tukeof@gmail.com"

COPY sources.list /etc/apt/sources.list

RUN apt-get update -y && apt-get install curl unzip vim dnsutils htop -y

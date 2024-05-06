FROM jerrywill/debian:9

MAINTAINER "tuke tukeof@gmail.com"

ADD https://dl.redpanda.com/nzc4ZYQK3WRGd9sy/redpanda/cfg/setup/bash.deb.sh /bash.deb.sh

RUN apt-get update && apt-get install curl && \
    curl -1sLf 'https://dl.redpanda.com/nzc4ZYQK3WRGd9sy/redpanda/cfg/setup/bash.deb.sh' | \
    bash \
    apt-get install redpanda-console -y

EXPOSE 8082/tcp
EXPOSE 9644/tcp


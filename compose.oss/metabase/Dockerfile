FROM jerrywill/jre:17

MAINTAINER "tuke tukeof@gmail.com"

# https://www.metabase.com/start/oss/jar
# https://downloads.metabase.com/v0.50.6/metabase.jar
ENV METABASE_VERSION=v0.50.6
ENV MB_CONFIG_FILE_PATH=/opt/metabase/config.yml

EXPOSE 3000

WORKDIR /opt/metabase

RUN apt-get update -y && \
    apt-get install -y curl jq

RUN curl -o /opt/metabase/metabase.jar https://downloads.metabase.com/$METABASE_VERSION/metabase.jar

COPY entrypoint.sh /opt/metabase/entrypoint.sh

CMD touch /opt/metabase/metabase.log && \
    bash -c '/opt/metabase/entrypoint.sh &' && \
    tail -n +1 -f /opt/metabase/metabase.log

#docker build -t jerrywill/metabase .

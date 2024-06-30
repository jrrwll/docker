FROM jerrywill/oraclejre:8

MAINTAINER "tuke tukeof@gmail.com"

# https://www.metabase.com/start/oss/jar
# https://downloads.metabase.com/v0.50.6/metabase.jar
ENV METABASE_VERSION=v0.50.6

ENV MB_CONFIG_FILE_PATH=/opt/metabase/config.yml

ADD https://downloads.metabase.com/$METABASE_VERSION/metabase.jar /opt/metabase/metabase.jar

EXPOSE 3000

ENTRYPOINT java -jar /opt/metabase/metabase.jar

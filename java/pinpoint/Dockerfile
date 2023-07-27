FROM bobbystrange/hbase

LABEL maintainer="tukeof@gmail.com" \
      version="1.0" \
      description="pinpoint image"

WORKDIR /usr/local

ENV TOMCAT_VERSION=9.0.16
# install tomcat
RUN apt-get update -y && apt-get install -y wget && \
    echo "Preparing tomcat..." && \
    wget http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    apt-get remove -y wget && \
    tar xfz apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    mv apache-tomcat-${TOMCAT_VERSION} tomcat

ENV PINPOINT_VERSION=1.8.2
# deploy pinpoint to tomcat
RUN apt-get update -y && apt-get install -y wget && \
    echo "Preparing pinpoint..." && \
    wget https://github.com/naver/pinpoint/releases/download/${PINPOINT_VERSION}/pinpoint-collector-${PINPOINT_VERSION}.war && \
    wget https://github.com/naver/pinpoint/releases/download/${PINPOINT_VERSION}/pinpoint-web-${PINPOINT_VERSION}.war && \
    rm -rf tomcat/webapps/* && \
    mv pinpoint-web-${PINPOINT_VERSION}.war tomcat/webapps/ROOT.war && \
    mkdir -p tomcat/webapps-pinpoint && \
    mv pinpoint-collector-${PINPOINT_VERSION}.war tomcat/webapps-pinpoint/ROOT.war

COPY hbase-create.rb ${HBASE_HOME}/bin
COPY server.xml /usr/local/tomcat/conf

# extends from hbase
EXPOSE 16010 16030
# pinpoint web
EXPOSE 8080
# pinpoint collector
EXPOSE 9994

CMD ${HBASE_HOME}/bin/start-hbase.sh && \
    ${HBASE_HOME}/bin/hbase shell ${HBASE_HOME}/bin/hbase-create.rb && \
    ./tomcat/bin/catalina.sh run

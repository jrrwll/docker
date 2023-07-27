FROM bobbystrange/oraclejre:8

MAINTAINER "tuke bobby.j.strange@gmail.com"

ENV METERSPHERE_VERSION=1.6.2
ENV METERSPHERE_HOME=/opt/metersphere-release-v${METERSPHERE_VERSION}

# wget --no-check-certificate https://github.com/metersphere/metersphere/releases/download/v1.6.2/metersphere-release-v1.6.2.tar.gz

ADD metersphere-release-v1.6.2.tar.gz /opt

WORKDIR ${METERSPHERE_HOME}

RUN cd ${METERSPHERE_HOME} && \
    sed -i -e "s#MS_TAG=.*#MS_TAG=v${METERSPHERE_VERSION}#g" install.conf && \
    sed -i -e "s#MS_PREFIX=.*#MS_PREFIX=registry.cn-hangzhou.aliyuncs.com\/metersphere#g" install.conf && \
    /bin/bash install.sh

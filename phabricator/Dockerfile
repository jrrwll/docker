FROM centos

LABEL maintainer="tukeof@gmail.com" \
      version="1.0" \
      description="phabricator image"

WORKDIR /usr/local/src

# install php
RUN yum install -y php php-cli php-mysql php-process php-devel php-gd php-pecl-apc php-pecl-json php-mbstring

# install apc
RUN yum install -y gcc make && \
    yum install -y pcre-devel php-pear && echo "no" | pecl install apc && \
    echo "extension=apc.so" > /etc/php.d/apc.ini && \
    yum remove -y gcc make

# clone phabricator
RUN yum install -y git && \
    git clone https://github.com/phacility/libphutil.git && \
    git clone https://github.com/phacility/arcanist.git && \
    git clone https://github.com/phacility/phabricator.git && \
    yum remove -y git

COPY httpd.conf /etc/httpd/conf/httpd.conf

EXPOSE 80

CMD if [ "" = "$MYSQL_HOST" -o "" = "$MYSQL_PASS" ]; then echo "please set MYSQL_HOST and MYSQL_PASS" && exit 1; fi && \
    if [ "" = "`echo "$PHABRICATOR_DOMAIN" | grep -E '^([0-9a-zA-Z]+\.)+?[0-9a-zA-Z]+?$'`" ]; then echo "please set PHABRICATOR_DOMAIN" && exit 1; fi && \
    sed -i "s/\$PHABRICATOR_DOMAIN/${PHABRICATOR_DOMAIN}/1" /etc/httpd/conf/httpd.conf && \
    ./phabricator/bin/config set mysql.host ${MYSQL_HOST} && \
    ./phabricator/bin/config set mysql.port ${MYSQL_PORT=3306} && \
    ./phabricator/bin/config set mysql.user ${MYSQL_USER=root} && \
    ./phabricator/bin/config set mysql.pass ${MYSQL_PASS} && \
    ./phabricator/bin/storage upgrade --force && \
    httpd && bash

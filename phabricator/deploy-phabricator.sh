#!/usr/bin/env bash

# you must run a mysql first or provide one
docker run -d --hostname phabricator_mysql --name phabricator_mysql \
    -e MYSQL_ROOT_PASSWORD=root \
    mysql:5.7

# wait mysql to  accept connections
timeout=30
while ! docker exec phabricator_mysql mysqladmin -uroot -proot status >/dev/null 2>&1; do
    timeout=$(($timeout - 1))
    if [ $timeout -eq 0 ]; then
        echo -e "\nCould not connect to database server. Aborting..."
        exit 1
    fi
    echo -n "."
    sleep 1
done

# deploy phabricator website
# if you use example.com, make sure you modified /etc/hosts like this:
# 127.0.0.1 localhost example.com
YOUR_DOMAIN=example.com
docker run -d -it --name phabricator --hostname phabricator \
    -p 80:80 \
    --link phabricator_mysql \
    -e MYSQL_HOST=phabricator_mysql \
    -e MYSQL_PASS=root\
    -e PHABRICATOR_DOMAIN=example.com \
    foekut/phabricator

# ==== ==== ==== ====    ==== ==== ==== ====    ==== ==== ==== ====

## native mysql mode
#wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
#rpm -ivh mysql-community-release-el7-5.noarch.rpm
#yum install -y mysql-server
#
#mysql_install_db
#systemctl start  mysqld
#/usr/bin/mysqladmin -u root password 'root'
#systemctl enable  mysqld

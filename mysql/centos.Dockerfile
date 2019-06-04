FROM centos

MAINTAINER "tuke tukeof@gmail.com"

RUN yum install -y epel-release wget && \
    wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm && \
    rpm -ivh mysql-community-release-el7-5.noarch.rpm && \
    yum install -y mysql-server && \
    sed -i '/\[mysqld\]/a user=mysql' /etc/my.cnf && \
    sed -i '/\[mysqld\]/a bind-address=0.0.0.0' /etc/my.cnf

COPY entrypoint.sh /usr/local/bin/

EXPOSE 3306

CMD mysql_install_db && \
    chown -R mysql /var/lib/mysql && \
    bash -c '/usr/local/bin/entrypoint.sh &' && \
    mysqld

#!/usr/bin/env bash

docker-compose up -d
# sudo apt install default-mysql-client
docker run --network bigdata -it --rm freeoneplus/apache-doris:register bash

# no password required
mysql -h 172.20.80.2 -P 9030 -uroot

# todo impl
#!/bin/sh
echo "Welcome to Apache-Doris Docker-Compose to quickly build test images!"
echo "Start modifying the configuration files of FE and BE and run FE and BE!"
docker cp /root/init_fe.sh doris-fe:/root/init_fe.sh
docker exec doris-fe bash -c "/root/init_fe.sh"
docker cp /root/init_be.sh doris-be:/root/init_be.sh
docker exec doris-be bash -c "/root/init_be.sh"
sleep 30
echo "Get started with the Apache Doris registration steps!"
mysql -h 172.20.80.2 -P 9030 -uroot -e "ALTER SYSTEM ADD BACKEND \"172.20.80.3:9050\";"
echo "The initialization task of Apache-Doris has been completed, please start to experience it!"

cat <<EOF > init_fe.sh
#!/bin/bash
echo "Start initializing Apache-Doris FE!"
perl -pi -e "s|# priority_networks = 10.10.10.0/24;192.168.0.0/16|priority_networks = 172.0.0.0/8|g" /usr/local/apache-doris/fe/conf/fe.conf
start_fe.sh --daemon
echo "Apache-Doris FE initialized successfully!"
EOF

cat <<EOF > init_be.sh
#!/bin/bash
echo "Start initializing Apache-Doris BE!"
perl -pi -e "s|# priority_networks = 10.10.10.0/24;192.168.0.0/16|priority_networks = 172.0.0.0/8|g" /usr/local/apache-doris/be/conf/be.conf
start_be.sh --daemon
echo "Apache-Doris BE initialized successfully!"
EOF


mysql -h 172.23.0.3 -P 9030 -uroot -e "ALTER SYSTEM ADD BACKEND \"172.23.0.2:9050\";"

#!/usr/bin/env bash

# psql -h 127.0.0.1 -p 5432 -d sonarqube -U sonarqube -W
cat <<EOF >> /etc/postgresql/11/main/pg_hba.conf

host    sonarqube    sonarqube    0.0.0.0/0    md5
host    sonarqube    sonarqube    ::/0         md5

EOF

systemctl restart postgresql


# use `host.docker.internal` in Mac alternatively
ip addr show docker0

#SONAR_JDBC_URL=jdbc:postgresql://172.17.0.1:5432/sonarqube


sudo bash -c "echo '\nvm.max_map_count=262144\n' >> /etc/sysctl.conf"
sudo sysctl  -p

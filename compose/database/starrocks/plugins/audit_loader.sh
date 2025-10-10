#!/usr/bin/env bash

if [ -f AuditLoader.zip ]; then
  echo -e "\033[32mfound AuditLoader.zip\033[0m"
else
    wget https://releases.mirrorship.cn/resources/AuditLoader.zip
fi

for i in starrocks-fe-1 starrocks-fe-2 starrocks-fe-3; do
  docker cp ./AuditLoader.zip $i:/opt
done

mysql -h 127.0.0.1 -P9030 -uroot < ./starrocks_audit_tbl__.sql

mysql -h 127.0.0.1 -P9030 -uroot -e "
install plugin from '/opt/AuditLoader.zip';
show plugins;
"

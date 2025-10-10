#!/bin/bash

MYSQL_HOST="127.0.0.1"
MYSQL_PORT="3306"
MYSQL_USER="root"
MYSQL_PASS="root"
BACKUP_DIR="./tidb_backup"
DATABASE="testdb"

# 创建数据库
mysql -u $MYSQL_USER -p$MYSQL_PASS -h $MYSQL_HOST -P $MYSQL_PORT -e "CREATE DATABASE IF NOT EXISTS $DATABASE"

# 导入表结构（所有 -schema.sql 文件）
for schema_file in $BACKUP_DIR/*-schema.sql; do
echo "Importing schema: $schema_file"
mysql -u $MYSQL_USER -p$MYSQL_PASS -h $MYSQL_HOST -P $MYSQL_PORT $DATABASE < "$schema_file"
done

# 导入数据（所有 .sql 文件，排除 -schema.sql）
for data_file in $BACKUP_DIR/*.sql; do
if [[ $data_file != *"-schema.sql" ]]; then
echo "Importing data: $data_file"
mysql -u $MYSQL_USER -p$MYSQL_PASS -h $MYSQL_HOST -P $MYSQL_PORT $DATABASE < "$data_file"
fi
done
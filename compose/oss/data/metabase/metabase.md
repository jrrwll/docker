## doc

https://www.metabase.com/docs/latest/configuring-metabase/environment-variables

https://www.metabase.com/docs/latest/questions/sharing/alerts

https://github.com/metabase/metabase/blob/master/docs/api/alert.md

## install

### h2

```shell

docker run -d --name metabase \
  -p 3000:3000 \
  -v ./metabase-config.yml:/app/metabase-config.yml \
  -e "MB_CONFIG_FILE_PATH=/app/metabase-config.yml" \
  metabase/metabase
```

### mysql

```shell
docker exec -it mysql mysql -uroot -p \
  -e 'create database if not exists metabase'

docker run -d --name metabase \
  -p 3000:3000 \
  -v ./metabase-config.yml:/app/metabase-config.yml \
  -e "MB_CONFIG_FILE_PATH=/app/metabase-config.yml" \
  --link mysql --network dev \
  -e "MB_DB_TYPE=mysql" \
  -e "MB_DB_DBNAME=metabase" \
  -e "MB_DB_PORT=3306" \
  -e "MB_DB_USER=root" \
  -e "MB_DB_PASS=root" \
  -e "MB_DB_HOST=mysql" \
  -e "MB_SITE_LOCALE: zh" \
  metabase/metabase
```

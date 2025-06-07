> https://github.com/nextcloud/docker
> https://download.nextcloud.com/android/

```shell
# -e NEXTCLOUD_TRUSTED_DOMAINS=127.0.0.1,192.168.1.0/24
docker run -itd --name nextcloud \
  -p 7080:80 \
  -v ./data:/var/www/html/data \
  nextcloud
```

```shell
# -e REDIS_HOST, REDIS_HOST_PORT=6379, REDIS_PASSWORD
# -e POSTGRES_HOST POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB
docker run -itd --name nextcloud \
  --network dev \
  -e MYSQL_HOST=mysql \
  -e MYSQL_USER=nextcloud \
  -e MYSQL_PASSWORD=nextcloud \
  -e MYSQL_DATABASE=nextcloud \
  -e NEXTCLOUD_ADMIN_USER=root \
  -e NEXTCLOUD_ADMIN_PASSWORD=root \
  -e NEXTCLOUD_TRUSTED_DOMAINS="192.168.1.* nextcloud.dev.dreamcat.org" \
  -p 7080:80 \
  -v ./nextcloud:/var/www/html/data \
  nextcloud
```

```shell
docker exec -it mysql mysql -uroot -p$MYSQL_ADMIN_PASSWORD -e '
create database nextcloud;
create user "nextcloud"@"%" identified by "nextcloud";
grant all privileges on nextcloud.* to "nextcloud"@"%";
'
```

```shell
cat <<EOF > nextcloud.dev.dreamcat.org.conf
server {
    listen       80;
    server_name  nextcloud.dev.dreamcat.org;

    location / {
        proxy_pass http://$LOCAL_IP:7080;
    }

    location /health {
        add_header Content-Type "text/plain;charset=utf-8";
        return 200 "Your IP Address:\$remote_addr";
    }
}
EOF
```

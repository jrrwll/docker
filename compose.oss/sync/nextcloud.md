> https://github.com/nextcloud/docker
> https://download.nextcloud.com/android/

```shell
# -e NEXTCLOUD_TRUSTED_DOMAINS=127.0.0.1,192.168.1.0/24
docker run -itd --name nextcloud \
  -p 8080:80 \
  -v ./data:/var/www/html/data \
  nextcloud
```

```shell
# -e REDIS_HOST, REDIS_HOST_PORT=6379, REDIS_PASSWORD
# -e POSTGRES_HOST POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB
docker run -itd --name nextcloud \
  --like mysql \
  -e MYSQL_HOST=mysql \
  -e MYSQL_USER=nextcloud \
  -e MYSQL_PASSWORD=nextcloud \
  -e MYSQL_DATABASE=nextcloud \
  -e NEXTCLOUD_ADMIN_USER=root \
  -e NEXTCLOUD_ADMIN_PASSWORD=root \
  -p 8080:80 \
  -v ./data:/var/www/html/data \
  nextcloud
```



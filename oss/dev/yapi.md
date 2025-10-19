
## step1: start mongo

```shell
docker run -itd --name mongo \
    --privileged=true \
    -p 27017:27017 \
    -v ./mongo:/data/db \
    -e MONGO_INITDB_ROOT_USERNAME=admin \
    -e MONGO_INITDB_ROOT_PASSWORD=Admin@123 \
    mongo
```

```mongodb-json
// docker exec -it mongo mongosh -u admin -p Admin@123 --authenticationDatabase admin
use admin

db.getUsers()

db.createUser({
  user: "yapi",
  pwd: "yapi",
  roles: [{ role: "readWrite", db: "yapi" }]
})
```

## step2: start yapi

```shell
docker run -d --name yapi \
    --link mongo \
    -p 3000:3000 \
    -e YAPI_ADMIN_ACCOUNT=admin@dreamcat.org \
    -e YAPI_ADMIN_PASSWORD=admin \
    -e YAPI_CLOSE_REGISTER=true \
    -e YAPI_DB_SERVERNAME=mongo \
    -e YAPI_DB_PORT=27017 \
    -e YAPI_DB_DATABASE=yapi \
    -e YAPI_DB_USER=yapi \
    -e YAPI_DB_PASS=yapi \
    -e YAPI_DB_AUTH_SOURCE=admin \
    -e YAPI_MAIL_ENABLE=false \
    -e 'YAPI_PLUGINS=[]' \
    jayfong/yapi:1.10.2
```

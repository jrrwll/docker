## tiflash

```shell
# labels": [ { "key": "engine", "value": "tiflash" } ]
# curl http://pd:2379/pd/api/v1/stores
curl http://127.0.0.1:2379/pd/api/v1/stores
curl http://127.0.0.1:2379/pd/api/v1/cluster
curl http://127.0.0.1:2379/pd/api/v1/config/rules/group/tiflash
```

## backup

```shell
mysql -h 127.0.0.1 -P 4000 -u root

docker run -it --rm pingcap/dumpling \
  -h 127.0.0.1 -P 4000 -u root \
  -o /backup/data --filetype sql
```



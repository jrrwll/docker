## tiflash

```sql
select * from information_schema.cluster_info;
select * from information_schema.cluster_hardware;
select * from information_schema.tiflash_replica;
select * from information_schema.tikv_store_status;
select * from information_schema.tikv_region_peers;

use test;
create table my_table(id int, name varchar(100));
insert into test.my_table values (1, 'a'), (2, 'b');
alter table my_table set tiflash replica 1;

-- query regions
show table my_table regions;

-- force read tiflash
set session tidb_isolation_read_engines = 'tiflash';-- default is tikv,tiflash,tidb
explain select name, avg(id), sum(id) from my_table group by name;
-- or hint
select /*+ read_from_storage(tiflash[test.my_table]) */ name, avg(id), sum(id) from my_table group by name;
```

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



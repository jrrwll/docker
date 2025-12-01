
-- type = 'tiflash'
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

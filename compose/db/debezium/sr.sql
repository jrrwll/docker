use mydb1;

create table `mytable1` (
    `id` bigint,
    `c1` varchar(30),
    `c2` double,
    `event_time` timestamp
) primary key (`id`)
distributed by hash(`id`)
order by (event_time)
;

create routine load mytable1_label on mytable1
columns(id, c1, c2, event_time)
properties
(
    "desired_concurrent_number" = "6",
    "format" = "json",
    "jsonpaths" = "[\"$.payload.after.id\",\"$.payload.after.c1\",\"$.payload.after.c2\",\"$.payload.after.event_time\"]"
)
from kafka
(
    "kafka_broker_list" = "<kafka_broker1_ip>:<kafka_broker1_port>,<kafka_broker2_ip>:<kafka_broker2_port>",
    "kafka_topic" = "mysql.mydb1.mytable1",
    "kafka_partitions" = "0,1,2,3,4",
    "property.kafka_default_offsets" = "offset_beginning"
);

show routine load for mytable1_label;

show routine load task where jobname = "mytable1_label";

# pause routine load for mytable1_label;

# resume routine load for mytable1_label;

# stop routine load for mytable1_label;

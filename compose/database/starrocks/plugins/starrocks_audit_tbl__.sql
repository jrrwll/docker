CREATE DATABASE starrocks_audit_db__;

CREATE TABLE starrocks_audit_db__.starrocks_audit_tbl__ (
    `queryId`           VARCHAR(64)                COMMENT "查询的唯一ID",
    `timestamp`         DATETIME         NOT NULL  COMMENT "查询开始时间",
    `queryType`         VARCHAR(12)                COMMENT "查询类型（query, slow_query, connection）",
    `clientIp`          VARCHAR(32)                COMMENT "客户端IP",
    `user`              VARCHAR(64)                COMMENT "查询用户名",
    `authorizedUser`    VARCHAR(64)                COMMENT "用户唯一标识，既user_identity",
    `resourceGroup`     VARCHAR(64)                COMMENT "资源组名",
    `catalog`           VARCHAR(32)                COMMENT "Catalog名",
    `db`                VARCHAR(96)                COMMENT "查询所在数据库",
    `state`             VARCHAR(8)                 COMMENT "查询状态（EOF，ERR，OK）",
    `errorCode`         VARCHAR(512)               COMMENT "错误码",
    `queryTime`         BIGINT                     COMMENT "查询执行时间（毫秒）",
    `scanBytes`         BIGINT                     COMMENT "查询扫描的字节数",
    `scanRows`          BIGINT                     COMMENT "查询扫描的记录行数",
    `returnRows`        BIGINT                     COMMENT "查询返回的结果行数",
    `cpuCostNs`         BIGINT                     COMMENT "查询CPU耗时（纳秒）",
    `memCostBytes`      BIGINT                     COMMENT "查询消耗内存（字节）",
    `stmtId`            INT                        COMMENT "SQL语句增量ID",
    `isQuery`           TINYINT                    COMMENT "SQL是否为查询（1或0）",
    `feIp`              VARCHAR(128)               COMMENT "执行该语句的FE IP",
    `stmt`              VARCHAR(1048576)           COMMENT "原始SQL语句",
    `digest`            VARCHAR(32)                COMMENT "慢SQL指纹",
    `planCpuCosts`      DOUBLE                     COMMENT "查询规划阶段CPU占用（纳秒）",
    `planMemCosts`      DOUBLE                     COMMENT "查询规划阶段内存占用（字节）"
) ENGINE = OLAP DUPLICATE KEY (`queryId`, `timestamp`, `queryType`)
COMMENT "审计日志表"
PARTITION BY RANGE (`timestamp`) ()
DISTRIBUTED BY HASH (`queryId`) BUCKETS 3
PROPERTIES (
    "dynamic_partition.time_unit" = "DAY",
    -- 表示只保留最近30天的审计信息，可视需求调整。
    "dynamic_partition.start" = "-30",
    "dynamic_partition.end" = "3",
    "dynamic_partition.prefix" = "p",
    "dynamic_partition.buckets" = "3",
    "dynamic_partition.enable" = "true",
    -- 若集群中BE个数不大于3，可调整副本数为1，生产集群不推荐调整。
    "replication_num" = "3"
);

SHOW PARTITIONS FROM starrocks_audit_db__.starrocks_audit_tbl__;

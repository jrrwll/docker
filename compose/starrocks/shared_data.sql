create storage volume default_storage_volume
    type = s3 locations = ("s3://starrocks")
    properties (
        "enabled" = "true",
        "aws.s3.region" = "us-east1",
        "aws.s3.endpoint" = "***",
        "aws.s3.access_key" = "***",
        "aws.s3.secret_key" = "***",
        "aws.s3.enable_partitioned_prefix" = "true"
    );
set default_storage_volume as default storage volume;

show storage volumes;

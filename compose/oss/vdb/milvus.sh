

# HTTP 19530
# gRPC 9091
docker run -itd --name milvus \
    --network dev \
    -p 19530:19530 \
    -p 9091:9091 \
    -v ./milvus:/var/lib/milvus \
    -e ETCD_ENDPOINTS=etcd:2379 \
    -e MINIO_ADDRESS=minio:9000 \
    milvusdb/milvus milvus run standalone


docker run -itd --name attu \
    --network dev \
    -p 3530:3000 \
    -e MILVUS_URL=milvus:19530 \
    zilliz/attu

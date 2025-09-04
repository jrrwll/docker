
# HTTP 19530
# gRPC 9091
# user:password root:Milvus
docker run -itd --name milvus \
    --network dev \
    -p 19530:19530 \
    -p 9091:9091 \
    -v ./milvus:/var/lib/milvus \
    -e ETCD_ENDPOINTS=etcd:2379 \
    -e MINIO_ADDRESS=minio:9000 \
    milvusdb/milvus milvus run standalone


# docker pull zilliz/attu --platform linux/amd64
docker run -itd --name attu \
    --network dev \
    -p 3530:3000 \
    -e MILVUS_URL=milvus:19530 \
    zilliz/attu


cat <<EOF > milvus-attu.dev.dreamcat.org.conf
server {
    listen       80;
    server_name  milvus-attu.dev.dreamcat.org;

    location / {
        proxy_pass http://$LOCAL_IP:3530/;
    }
}
EOF

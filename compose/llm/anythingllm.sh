
# https://github.com/Mintplex-Labs/anything-llm/blob/master/docker/HOW_TO_USE_DOCKER.md

mkdir anythingllm && cd anythingllm
mkdir -p storage collector/hotdir collector/outputs

# --add-host=host.docker.internal:host-gateway
docker run -d --name anythingllm \
    --cap-add SYS_ADMIN \
    -e STORAGE_DIR=/app/server/storage \
    -v ${PWD}/storage/:/app/server/storage \
    -v ${PWD}/collector/hotdir/:/app/collector/hotdir \
    -v ${PWD}/collector/outputs/:/app/collector/outputs \
    -p 3001:3001 \
    mintplexlabs/anythingllm


cat <<EOF > anythingllm.dev.dreamcat.org.conf
server {
    listen       80;
    server_name  anythingllm.dev.dreamcat.org;

    location / {
        proxy_pass http://$LOCAL_IP:3001/;
    }
}
EOF

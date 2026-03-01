
sed -i 's/postgres:15-alpine/postgres:16/' docker-compose.yaml
sed -i 's/redis:6-alpine/redis/' docker-compose.yaml

docker_mirror_prefix=
if [ -n $DOCKER_MIRROR ]; then
    docker_mirror_prefix=$DOCKER_MIRROR/
fi

echo '
langgenius/dify-api:1.5.0
langgenius/dify-web:1.5.0
langgenius/dify-sandbox:0.2.12
langgenius/dify-plugin-daemon:0.1.2-local
ubuntu/squid
certbot/certbot
langgenius/qdrant:v1.7.3
' | while read i; do
    image_name=${docker_mirror_prefix}${i}
    echo "pulling ${image_name}"
    (
        docker pull $image_name
    ) &
done
wait
echo 'done'


# https://github.com/open-webui/open-webui

mkdir open-webui

docker run -d --name open-webui \
    -p 3002:8080 \
    -e OLLAMA_BASE_URL=http://${OLLAMA_HOST:-127.0.0.1}:11434 \
    -v ./open-webui:/app/backend/data \
    ghcr.io/open-webui/open-webui:main


cat <<EOF > open-webui.dev.dreamcat.org.conf
server {
    listen       80;
    server_name  open-webui.dev.dreamcat.org;

    location / {
        proxy_pass http://$LOCAL_IP:3002/;
    }
}
EOF


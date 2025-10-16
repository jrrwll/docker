
# https://prometheus.io/docs/prometheus/latest/installation/

# -v ./config:/etc/prometheus
docker run -d --name prometheus \
    -p 9090:9090 \
    -v ./config/prometheus.yml:/etc/prometheus/prometheus.yml \
    -v ./data:/prometheus \
    prom/prometheus

# https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/

# -e "GF_LOG_LEVEL=debug"
docker run -d --name grafana \
    -p 3000:3000 \
    --user "$(id -u)" \
    -v ./data:/var/lib/grafana \
    grafana/grafana

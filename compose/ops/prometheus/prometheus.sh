
# https://prometheus.io/docs/prometheus/latest/installation/

# -v ./config:/etc/prometheus
docker run -d --name prometheus \
    --network dev \
    --user "$(id -u)" \
    -p 9090:9090 \
    -v ./config/prometheus.yaml:/etc/prometheus/prometheus.yaml \
    -v ./data:/prometheus \
    prom/prometheus

# https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/

# -e "GF_LOG_LEVEL=debug"
docker run -d --name grafana \
    --network dev \
    --user "$(id -u)" \
    -p 3000:3000 \
    -e GF_SECURITY_ADMIN_PASSWORD=admin \
    -v ./data:/var/lib/grafana \
    grafana/grafana

docker run -d --name prom-node-exporter \
    --network dev \
    --user "$(id -u)" \
    -p 9100:9100 \
    -v "/proc:/host/proc:ro" \
    -v "/sys:/host/sys:ro" \
    -v "/:/rootfs:ro" \
    prom/node-exporter \
    --path.procfs /host/proc \
    --path.sysfs /host/sys \
    --path.rootfs /rootfs

# https://grafana.com/docs/grafana-cloud/knowledge-graph/enable-prom-metrics-collection/data-stores/mysql/
docker run -d --name prom-mysql-exporter \
    --network dev \
    -p 9104:9104 \
    -v ./my.cnf:/opt/my.cnf:ro \
    prom/mysqld-exporter \
    --config.my-cnf /opt/my.cnf

cat <<EOF > broker.conf
namesrvAddr=rocketmq-namesrv:9876
brokerClusterName=DefaultCluster
brokerName=broker1
brokerId=1
brokerRole=ASYNC_MASTER
flushDiskType=ASYNC_FLUSH
EOF

mkdir -p data/broker1

docker run -d --name rocketmq-namesrv \
    -p 9876:9876 \
    apache/rocketmq:5.3.2 \
    sh mqnamesrv

docker run -d --name rocketmq-broker \
    --link rocketmq-namesrv \
    -e "NAMESRV_ADDR=rocketmq-namesrv:9876" \
    -p 10911:10911 -p 10909:10909 \
    -v ./broker.conf:/home/rocketmq/broker.conf \
    -v ./data/broker1:/home/rocketmq/store \
    apache/rocketmq:5.3.2 \
    sh mqbroker -c /home/rocketmq/broker.conf

docker run -d --name rocketmq-dashboard \
    --link rocketmq-namesrv \
    -p 8082:8082 \
    -e "JAVA_OPTS=-Xms256m -Xmx256m -Drocketmq.namesrv.addr=rocketmq-namesrv:9876" \
    apacherocketmq/rocketmq-dashboard

#!/usr/bin/env bash


docker run -d --name pinpoint \
    -p 8080:8080 -p 9994:9994 \
    tukeof/pinpoint

java -server
    -javaagent:/path/to/pinpoint-agent-1.8.2/pinpoint-bootstrap-1.8.2.jar \
    -Dpinpoint.agentId=YOUR_AGENT_ID \
    -Dpinpoint.applicationName=YOUR_APP_NAME \
    -Dprofiler.collector.ip=$(docker inspect --format='{{.NetworkSettings.IPAddress }}' pinpoint) \
    -jar awesome.jar


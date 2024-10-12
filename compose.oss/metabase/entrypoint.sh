#!/bin/bash

LOG_FILE=/opt/metabase/metabase.log
nohup java -jar /opt/metabase/metabase.jar > $LOG_FILE  2>&1 &

METABASE_HOST=localhost
METABASE_PORT=3000
SITE_NAME=${SITE_NAME:-Metabase}
ADMIN_EMAIL=${ADMIN_EMAIL:-admin@metabase.com}
ADMIN_PASSWORD=Metabase@123
ADMIN_FULL_NAME=${ADMIN_FULL_NAME:-John Doe}
ADMIN_FIRST_NAME=$(echo $ADMIN_FULL_NAME | cut -d' ' -f1)
ADMIN_LAST_NAME=$(echo $ADMIN_FULL_NAME | cut -c $((${#ADMIN_FIRST_NAME} + 2))-)

echo "⌚︎ Waiting for Metabase to start" >> $LOG_FILE
while (! curl -s -m 5 http://${METABASE_HOST}:${METABASE_PORT}/api/session/properties -o /dev/null); do sleep 5; done

echo "😎 Creating admin user" >> $LOG_FILE

HAS_USER_SETUP=$(curl -s -m 5 -X GET \
    -H "Content-Type: application/json" \
    http://${METABASE_HOST}:${METABASE_PORT}/api/session/properties \
    | jq -r '.["has-user-setup"]'
)
if [[ $HAS_USER_SETUP = 'true' ]]; then
  echo "😯 Already setup, skip it" >> $LOG_FILE
  exit 0
fi

SETUP_TOKEN=$(curl -s -m 5 -X GET \
    -H "Content-Type: application/json" \
    http://${METABASE_HOST}:${METABASE_PORT}/api/session/properties \
    | jq -r '.["setup-token"]'
)

MB_TOKEN=$(curl -s -X POST \
    -H "Content-type: application/json" \
    http://${METABASE_HOST}:${METABASE_PORT}/api/setup \
    -d '{
    "token": "'${SETUP_TOKEN}'",
    "user": {
        "email": "'${ADMIN_EMAIL}'",
        "first_name": "'${ADMIN_FIRST_NAME}'",
        "last_name": "'${ADMIN_LAST_NAME}'",
        "password": "'${ADMIN_PASSWORD}'"
    },
    "prefs": {
        "allow_tracking": false,
        "site_name": "'${SITE_NAME}'"
    }
}' | jq -r '.id')

echo "🤣 Success to setup and get MB_TOKEN $MB_TOKEN" >> $LOG_FILE

# BASIC_USERS='[{.first_name, .last_name, .email, .region_filter, .password}]'
if [[ -n $BASIC_USERS ]]; then
  echo -e "\n👥 Creating some basic users: " >> $LOG_FILE
  echo $$BASIC_USERS | jq -c '.[]' | while read json; do
    json=$(echo $json | jq '.login_attributes.region_filter = .region_filter | del(.region_filter)')
    curl -s "http://${METABASE_HOST}:${METABASE_PORT}/api/user" \
        -H 'Content-Type: application/json' \
        -H "X-Metabase-Session: ${MB_TOKEN}" \
        -d "$json"
  done
  echo -e "\n👥 Basic users created!" >> $LOG_FILE
fi


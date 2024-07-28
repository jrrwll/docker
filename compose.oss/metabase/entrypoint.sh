#!/bin/bash

LOG_FILE=/opt/metabase/metabase.log

ADMIN_FULL_NAME=${ADMIN_FULL_NAME:John Doe}
ADMIN_FIRST_NAME=$(echo $ADMIN_FULL_NAME | cut -d' ' -f1)
ADMIN_LAST_NAME=$(echo $ADMIN_FULL_NAME | cut -c $((${#ADMIN_FIRST_NAME} + 1))-)

echo "⌚︎ Waiting for Metabase to start" >> $LOG_FILE
while (! curl -s -m 5 http://${METABASE_HOST}:${METABASE_PORT}/api/session/properties -o /dev/null); do sleep 5; done

echo "😎 Creating admin user" >> $LOG_FILE

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
        "email": "'${ADMIN_EMAIL:admin@metabase.com}'",
        "first_name": "'${ADMIN_FIRST_NAME}'",
        "last_name": "'${ADMIN_LAST_NAME}'",
        "password": "'${ADMIN_PASSWORD:metabase}'"
    },
    "prefs": {
        "allow_tracking": false,
        "site_name": "Metawhat"
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


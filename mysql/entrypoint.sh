#!/bin/bash

echo -n "Waiting for database server to accept connections"

timeout=30
while ! mysqladmin -u root status >/dev/null 2>&1; do
    timeout=$(($timeout - 1))
    if [ $timeout -eq 0 ]; then
        echo -e "\nCould not connect to database server. Aborting..."
        exit 1
    fi
    echo -n "."
    sleep 1
done

echo  "Setting the root password"
mysqladmin -u root password "${MYSQL_PASSWORD=root}"
echo "Done."

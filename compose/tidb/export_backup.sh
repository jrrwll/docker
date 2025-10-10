#!/bin/bash

dumpling -u -proot -h 127.0.0.1 -P4000 -B testdb \
--consistency none \
-o ./tidb_backup \
--filetype sql --threads 8

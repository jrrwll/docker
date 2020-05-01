#!/usr/bin/env bash

REGISTRY=tukeof

cd `dirname $0`
WORK_DIR=`pwd`
BIN=`which build-docker`

echo '
# cdn fastly in China
debian
#centos
nginx

#oraclejre 8 1.8 1.8.0_241
#oraclejdk 8 1.8 1.8.0_241
#oraclejre 13 13.0.2
#oraclejdk 13 13.0.2
oraclejdk 14
cmake

ffmpeg
magick
magick-jre
pdf
pdf-jre
swftools
#font

nexus 3.21.1-01
#phabricator
ssdb 1.9.5
hbase 2.2.3
#hadoop
#pinpoint
'|
while read line; do
    [[ -z $line ]] && continue
    [[ -n `echo $line | grep "#"` ]] && continue

#    cd $WORK_DIR && $BIN $REGISTRY/$name ./$name
    echo $line | awk -v WORK_DIR=$WORK_DIR -v BIN=$BIN -v REGISTRY=$REGISTRY '{
        len = split($0, fields, " ");
        name = fields[1]
        if(len == 1){
            current_tag = "latest"
        } else {
            current_tag = fields[2]
        }

        print "cd " WORK_DIR " && " BIN " " REGISTRY "/" name ":" current_tag " ../" name

        if(len > 2){
            for(i=3;i<=len;i++){
                tag = fields[i]
                print "docker tag " REGISTRY "/" name ":" current_tag " " REGISTRY "/" name ":" tag
            }
        }
    }' | /usr/bin/env bash -
done
# /usr/bin/env bash -

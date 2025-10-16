#!/usr/bin/env bash

while read i; do
    if [[ ! -f $i.tar.gz ]]; then
        echo "skip $i.tar.gz since no exist"
        continue
    fi

    JRE_NAME=$(echo $i | cut -d'-' -f3)
    VERSION=$(echo $JRE_NAME | cut -d'e' -f2)
    MAJOR_VERSION=$(echo $VERSION | cut -d'.' -f1)
    echo "building jre:$MAJOR_VERSION from $JRE_NAME"
    tar xfvz $i.tar.gz
    mv $i $JRE_NAME
    tar cfvz $JRE_NAME.tar.gz $JRE_NAME/

    docker build -f $MAJOR_VERSION.Dockerfile -t jerrywill/jre:$MAJOR_VERSION .
    docker tag jerrywill/jre:$MAJOR_VERSION jerrywill/jre:$VERSION

    echo "\nMaybe you want to push your mirror image next:"
    echo "docker push jerrywill/jre:$MAJOR_VERSION"
    echo "docker push jerrywill/jre:$VERSION"
done <<EOF
zulu17.50.19-ca-jre17.0.11-linux_x64
zulu11.82.19-ca-jre11.0.28-linux_x64
EOF

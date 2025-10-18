#!/usr/bin/env bash

function build_arch() {
    i=$(echo $1 | rev | cut -d. -f3- | rev)
    if [[ ! -f $i.tar.gz ]]; then
        echo "skip $i.tar.gz since no exist"
        return
    fi

    if [[ $(echo $i | cut -d'_' -f2) = 'x64' ]]; then
        arch=amd64
    else
        arch=arm64
    fi

    JRE_NAME=$(echo $i | cut -d'-' -f3)
    VERSION=$(echo $JRE_NAME | cut -d'e' -f2 | cut -d'.' -f1)
    if [[ $JRE_NAME != jre* ]]; then
        return
    fi
    echo "building jre:$VERSION from $JRE_NAME"
    tar xfvz $i.tar.gz
    mv $i $JRE_NAME
    tar cfvz $JRE_NAME.tar.gz $JRE_NAME/

    docker build --platform linux/$arch -f $VERSION.Dockerfile -t jerrywill/jre:$VERSION-$arch .
    docker push jerrywill/jre:$VERSION-$arch
    rm -rf "$JRE_NAME" "$JRE_NAME.tar.gz"
}

function build_arch_manifest() {
    VERSION=$1

    docker manifest create jerrywill/jre:$VERSION \
        jerrywill/jre:$VERSION-arm64 \
        jerrywill/jre:$VERSION-amd64

    docker manifest annotate jerrywill/jre:$VERSION \
        jerrywill/jre:$VERSION-arm64 --arch arm64
    docker manifest annotate jerrywill/jre:$VERSION \
        jerrywill/jre:$VERSION-amd64 --arch amd64

    docker manifest push jerrywill/jre:$VERSION
}

# don't call it via source the script
if [ $# != 0 ]; then
    build_arch zulu11.82.19-ca-jre11.0.28-linux_x64.tar.gz
    build_arch zulu11.82.19-ca-jre11.0.28-linux_aarch64.tar.gz
    build_arch_manifest 11

    build_arch zulu17.60.17-ca-jre17.0.16-linux_x64.tar.gz
    build_arch zulu17.60.17-ca-jre17.0.16-linux_aarch64.tar.gz
    build_arch_manifest 17

    build_arch zulu21.44.17-ca-jre21.0.8-linux_x64.tar.gz
    build_arch zulu21.44.17-ca-jre21.0.8-linux_aarch64.tar.gz
    build_arch_manifest 21
fi

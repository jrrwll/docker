#!/usr/bin/env bash

version=v8.5.4

# .dockerignore
# !*..tar.gz
function download() {
    component=$1
    arch=$2
    file_name=$component-$version-linux-$arch.tar.gz
    url=https://tiup-mirrors.pingcap.com/$file_name
    if [[ -f $file_name ]]; then
        echo "$file_name already exist, skip it"
        return
    fi
    curl -L $url -o $file_name || echo "failed to download $url"
}

function build_arch() {
    component=$1
    arch=$2
    file_name=$component-$version-linux-$arch.tar.gz

    set -x
    if [[ ! -f $file_name ]]; then
        echo "skip $file_name since no exist"
        return
    fi

    echo "building $component:$version from $file_name"
    if [[ ! -f $component.tgz ]]; then
        cp $file_name $component.tgz
    fi

    image_name=jerrywill/$component:$version-$arch
    docker build --platform linux/$arch -f $component.Dockerfile -t $image_name .
    docker push $image_name
    rm -f "$component.tgz"
}

function build_arch_manifest() {
    component=$1

    set -x
    docker manifest create jerrywill/$component:$version \
        jerrywill/$component:$version-arm64 \
        jerrywill/$component:$version-amd64

    docker manifest annotate jerrywill/$component:$version \
        jerrywill/$component:$version-arm64 --arch arm64
    docker manifest annotate jerrywill/$component:$version \
        jerrywill/$component:$version-amd64 --arch amd64

    docker manifest push jerrywill/$component:$version
}

download pd amd64 &
download tidb amd64 &
download tikv amd64 &
download tiflash amd64 &

download pd arm64 &
download tidb arm64 &
download tikv arm64 &
download tiflash arm64 &

wait
echo "all downloads finished, start building..."

build_arch pd amd64
build_arch pd arm64
build_arch_manifest pd

build_arch tidb amd64
build_arch tidb arm64
build_arch_manifest tidb

build_arch tikv amd64
build_arch tikv arm64
build_arch_manifest tikv

build_arch tiflash amd64
build_arch tiflash arm64
build_arch_manifest tiflash

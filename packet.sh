#!/bin/bash

ROOT=$(dirname "$PWD")

rm -rf output || true
mkdir output

build() {
    project=${ROOT}/$1
    branch=$2
    echo "start to build project [${project}] with branch [${branch}]"
    cd ${project}
    git checkout ${branch}
    ./build.sh
    mv ./output ${ROOT}/installer/output/$1
    cd -
}

build algo-manager-service feat/v2
build client feat/v2
build config-manager-service main
build deploy main
build image-manager-service feat/v2
build manage-core-service main
build open-gateway main
build system-manager-service main
build video-ingress-service feat/v2
build video-process-service feat/v2

SUFFIX_GIT=$(git rev-parse --short HEAD)
SUFFIX_DATE=$(date "+%Y%m%d")
cd output 
mv algo-manager-service/cli client/test/
mv algo-manager-service/luaapp client/test/
tar -zcvf ./infuturetech-${SUFFIX_GIT}-${SUFFIX_DATE}.tar.gz ./

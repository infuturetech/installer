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

buildInDocker() {
    project=${ROOT}/$1
    branch=$2
    echo "start to build project [${project}] in docker with branch [${branch}]"
    cd ${project}
    git checkout ${branch}
    sudo ./build_in_docker.sh
    mv ./output ${ROOT}/installer/output/$1
    cd -
}

buildInDocker algo-manager-service feat/v4
build client feat/v4
build config-manager-service feat/v4
build deploy main
build image-manager-service feat/v4
build manage-core-service feat/v4
build open-gateway feat/v4
build system-manager-service feat/v4
build video-ingress-service feat/v4
build video-process-service feat/v4

SUFFIX_GIT=$(git rev-parse --short HEAD)
SUFFIX_DATE=$(date "+%Y%m%d")
cd output 
mv algo-manager-service/cli client/test/
mv algo-manager-service/luaapp client/test/
tar -zcvf ./infuturetech-${SUFFIX_GIT}-${SUFFIX_DATE}.tar.gz ./

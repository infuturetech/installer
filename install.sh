#!/bin/bash

ROOT=/infuturetech

load() {
    serviceName=$1
    systemctl enable ${serviceName}.service
    systemctl start ${serviceName}.service
    systemctl status ${serviceName}.service
}

install() {
    project=$1
    serviceName=$2
    echo "try to install ${project}"
    cp -r ./output/${project} ${ROOT}/
    cp ${ROOT}/${project}/${serviceName}.service /etc/systemd/system/
    load ${serviceName}
}

deployInstall() {
    cd ./output/deploy

    echo "try to install metrics"
    ./prepare.sh

    echo "try to install exporter"
    project=deploy

    mkdir -p ${ROOT}/${project}
    cp -r ./metrics ${ROOT}/${project}
    cp ${ROOT}/${project}/exporter/node_exporter.service /etc/systemd/system/
    load node_exporter
    cd -
}

prepare() {
    rm -rf output || true
    mkdir output
    cd output 
    wget https://github.com/infuturetech/installer/releases/download/debug-v4/infuturetech-73264ab-20240812.tar.gz
    tar -xzf infuturetech-73264ab-20240812.tar.gz
    cd -
}

prepare

mkdir -p ${ROOT}

install config-manager-service cms
install algo-manager-service ams
install image-manager-service ims
install open-gateway gateway
install system-manager-service sms
install video-ingress-service vis
install video-process-service vps
deployInstall

cp ./output/deploy/docker-compose.yml ${ROOT}/

docker-compose -f ${ROOT}/docker-compose.yml up -d

# echo "127.0.0.1       nsqd" >> /etc/hosts
# echo "wait mysql ready ..."
# sleep 60

# ./dep_db.sh
# echo "DONE !!!"
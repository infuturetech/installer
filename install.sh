#!/bin/bash

ROOT=/infuturetech

install() {
    project=$1
    serviceName=$2
    echo "try to install ${project}"
    cp -r ./output/${project} ${ROOT}/
    mv ${ROOT}/${project}/${serviceName}.service /etc/systemd/system/
    systemctl enable ${serviceName}.service
    systemctl start ${serviceName}.service
    systemctl status ${serviceName}.service
}

prepare() {
    rm -rf output || true
    mkdir output
    cd output 
    wget https://github.com/infuturetech/installer/releases/download/debug-20240315/infuturetech-dd33306-20240315.tar.gz
    tar -xzf infuturetech-dd33306-20240315.tar.gz
    cd -
}

prepare

mkdir -p ${ROOT}

install config-manager-service cms
install algo-manager-service ams
install image-manager-service ims
install manage-core-service mcs
install open-gateway gateway
install system-manager-service sms
install video-ingress-service vis
install video-process-service vps

cp ./output/deploy/docker-compose.yml ${ROOT}/
docker-compose -f ${ROOT}/docker-compose.yml up -d

echo "127.0.0.1       nsqd" >> /etc/hosts
echo "wait mysql ready ..."
sleep 60

./dep_db.sh
echo "DONE !!!"


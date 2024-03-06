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
    rm -rf output || mkdir output
    cd output
    wget https://github.com/infuturetech/installer/releases/download/debug-20240306/infuturetech-9fdcf68-20240306.tar.gz
    tar -xzf infuturetech-9fdcf68-20240306.tar.gz
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

cd output/deploy
docker-compose up -d
sleep 10
chmod +x ./deploy_sql.sh
./deploy_sql.sh
chmod +x ./deploy_sql_mcs.sh
./deploy_sql_mcs.sh
chmod +x ./deploy_sql_vis.sh
./deploy_sql_vis.sh

echo "127.0.0.1       nsqd" >> /etc/hosts

echo "DONE !!!"


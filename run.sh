ROOT=/infuturetech

install() {
    project=$1
    serviceName=$2
    echo "try to install ${project}"
    systemctl enable ${serviceName}.service
    systemctl start ${serviceName}.service
    systemctl status ${serviceName}.service
}

install config-manager-service cms
install algo-manager-service ams
install image-manager-service ims
install manage-core-service mcs
install open-gateway gateway
install system-manager-service sms
install video-ingress-service vis
install video-process-service vps
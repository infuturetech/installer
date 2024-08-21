#!/bin/bash

stop() {
    systemctl stop $1.service
    systemctl status $1.service
}

stop cms
stop ams
stop ims
stop gateway
stop sms
stop vis
stop vps
docker-compose -f /opt/infuturetech/docker-compose.yml down 
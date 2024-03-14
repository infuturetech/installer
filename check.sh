#!/bin/bash

watch() {
    systemctl status $1.service
}

watch cms
watch ams
watch ims
watch mcs
watch gateway
watch sms
watch vis
watch vps

curl http://localhost:8088/openapi/v1/system_info
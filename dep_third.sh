#!/bin/bash

programExists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

programExists ffmpeg
if [ $? -ne 0 ]; then
    VERSION=ffmpeg-6.0-arm64-static
    echo "install ${VERSION} ..."
    
    wget https://www.johnvansickle.com/ffmpeg/old-releases/${VERSION}.tar.xz
    tar -xzf ${VERSION}.tar.xz
    sudp cp ${VERSION}/ff* /usr/bin/
fi

programExists docker-compose
if [ $? -ne 0 ]; then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
fi
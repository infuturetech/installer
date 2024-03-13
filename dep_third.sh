#!/bin/bash

apt-get update
apt-get install -y docker-compose
apt-get install -y mysql-client

programExists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

VERSION=ffmpeg-6.0-arm64-static
echo "install ${VERSION} ..."
wget https://www.johnvansickle.com/ffmpeg/old-releases/${VERSION}.tar.xz
tar -xf ${VERSION}.tar.xz
cp ${VERSION}/ff* /usr/bin/

programExists docker-compose
if [ $? -ne 0 ]; then
    apt-get install docker-compose
fi
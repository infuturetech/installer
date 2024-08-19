NAME=wrapper-20240618-3f55fd9.tar.gz
wget https://github.com/infuturetech/installer/releases/download/debug/${NAME}
tar -xzf ${NAME}

echo "install wrapper to /opt/infuturetech/"
rm -rf /opt/infuturetech/wrapper || true
mv wrapper /opt/infuturetech/
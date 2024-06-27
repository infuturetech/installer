NAME=wrapper-20240618-3f55fd9.tar.gz
wget https://github.com/infuturetech/installer/releases/download/debug/${NAME}
tar -xzf ${NAME}

echo "install wrapper to /usr/local/"
rm -rf /usr/local/wrapper || true
mv wrapper /usr/local/
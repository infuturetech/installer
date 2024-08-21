NAME=wrapper-20240618-3f55fd9.tar.gz
if [ ! -f $NAME ];then
  wget https://github.com/infuturetech/installer/releases/download/debug/${NAME}
else
    tar -xzf ${NAME}
fi

echo "install wrapper to /opt/infuturetech/"
rm -rf /opt/infuturetech/wrapper || true
mkdir -p /opt/infuturetech/
mv wrapper /opt/infuturetech/
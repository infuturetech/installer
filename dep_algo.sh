TF_VERSION=2.13.0
ARCH=$(dpkg --print-architecture)
wget https://github.com/ika-rwth-aachen/libtensorflow_cc/releases/download/v${TF_VERSION}/libtensorflow-cc_${TF_VERSION}_${ARCH}.deb
sudo docker build -t algo:v1 -f algo.Dockerfile .
FROM thecanadianroot/opencv-cuda:ubuntu20.04-cuda11.3.1-opencv4.5.2-arm64

RUN mkdir -p /install
COPY libtensorflow-cc_2.13.0_arm64.deb /install
RUN cd /install && dpkg -i libtensorflow-cc_2.13.0_arm64.deb && ldconfig
RUN rm -rf /install
RUN echo '127.0.0.1 nsqd' >> /etc/hosts
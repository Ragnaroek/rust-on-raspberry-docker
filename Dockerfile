FROM debian:buster

ARG PI_TOOLS_GIT_REF=master
ARG RUST_VERSION=stable

# update system
RUN apt-get update && \
  apt-get install -y curl git gcc xz-utils sudo pkg-config unzip


# config and set variables
#
COPY build /tmp/build
RUN sh /tmp/build/user-setup.sh

USER cross

ENV HOME=/home/cross
ENV URL_GIT_PI_TOOLS=https://github.com/raspberrypi/tools.git \
    TOOLCHAIN_64=$HOME/pi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin \
    TOOLCHAIN_32=$HOME/pi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin

# install rustup with raspberry target
RUN sh /tmp/build/download-rust.sh

COPY bin/gcc-sysroot $HOME/pi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/gcc-sysroot
COPY bin/gcc-sysroot $HOME/pi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/gcc-sysroot

# configure cargo
COPY conf/cargo-config $HOME/.cargo/config

COPY bin $HOME/bin
ENV PATH=$HOME/bin:$PATH
ENTRYPOINT ["run.sh"]

CMD ["help"]

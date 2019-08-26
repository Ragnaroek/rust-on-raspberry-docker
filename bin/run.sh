#!/bin/bash

# This script is the entrypoint in the docker container.

set -ex;
export SYSROOT="$HOME/pi-tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/arm-linux-gnueabihf/sysroot";

printf "*** Extracting target dependencies ***\n";
if [ -d "$HOME/deb-deps" ]; then

  for i in `find $HOME/deb-deps -name "*.deb" -type f`; do
    echo "Extracting: $i in `pwd`";
    ar -p $i data.tar.xz > "$i.tar.xz";
    tar x -C $SYSROOT -f  "$i.tar.xz"
  done
fi

printf "*** Run the user specified post-install script, if present ***\n"
if [ -x "$HOME/deb-deps/post-install.sh" ] ; then
  source "$HOME/deb-deps/post-install.sh" $SYSROOT $HOME/deb-deps
fi

printf "\n*** Cross compiling project ***\n";
cd $HOME/project;

if [ $(uname -m) == 'x86_64' ]; then
	TOOLCHAIN=$TOOLCHAIN_64;
else
	TOOLCHAIN=$TOOLCHAIN_32;
fi

#Include the cross compilation binaries
export PATH=$TOOLCHAIN:$PATH;

# Setup environment variables for cross compilation.
# Note that cargo needs to compile build.rs for the local host and then the final library or bin for
# the target host.
export CC_arm_unknown_linux_gnueabihf="$TOOLCHAIN/gcc-sysroot"

flags="--target=arm-unknown-linux-gnueabihf";
$HOME/.cargo/bin/cargo "$@" $flags;

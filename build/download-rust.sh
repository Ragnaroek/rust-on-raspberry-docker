
# Exit if environment variables are not set
set -u

# Install rust through rustup
curl https://sh.rustup.rs -sSf > $HOME/install_rustup.sh
sh $HOME/install_rustup.sh -y --default-toolchain $RUST_VERSION
$HOME/.cargo/bin/rustup target add arm-unknown-linux-gnueabihf

# install pi tools
if [ $PI_TOOLS_GIT_REF = master ]; \
then git clone --depth 1 $URL_GIT_PI_TOOLS $HOME/pi-tools; \
else \
  git clone $URL_GIT_PI_TOOLS $HOME/pi-tools \
  && cd $HOME/pi-tools \
  && git reset --hard $PI_TOOLS_GIT_REF; \
fi


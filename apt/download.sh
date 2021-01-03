#!/bin/bash -e
# Downloads packages and their transitive deps into the current directory 
#
# Usage: ./download.sh [packages]
#
# Inspired from:
# https://stackoverflow.com/questions/13756800/how-to-download-all-dependencies-and-packages-to-directory
# https://stackoverflow.com/questions/22008193/how-to-list-download-the-recursive-dependencies-of-a-debian-package

PACKAGES="$@"

mkdir -p ./apt-tmp/

if [ ! -f ./apt-tmp/.update-done ]; then
  touch apt-tmp/status
  apt-get -c ./apt.conf update
  touch ./apt-tmp/.update-done
fi

ALL_DEPS=$(apt-cache -c ./apt.conf depends --recurse --no-recommends --no-suggests \
  --no-conflicts --no-breaks --no-replaces --no-enhances \
  --no-pre-depends ${PACKAGES} | grep "^\w")

echo -e "Downloading:\n ${ALL_DEPS}"

apt-get -c ./apt.conf download ${ALL_DEPS}

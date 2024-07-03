#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

SIZE_MIN=1
SIZE_MAX=128

SIZE=${1:-32}

function usage () {
  echo 'Usage: resize-swapfile.sh [size]'
  echo '  size  New swapfile size in GiB, 1 to 128 (default 32)'
  exit 1
}

if [[ $SIZE == '-h' ]]; then
  usage
fi

SIZE_PARSED=$(./util/parse_number.py $SIZE_MIN $SIZE_MAX $SIZE)
if [[ $SIZE_PARSED -eq -1 ]]; then
  usage
fi

SIZE_IN_KIB=$(( SIZE_PARSED * 1024 * 1024 ))
sudo swapoff --all
sudo dd bs=1024 "count=${SIZE_IN_KIB}" if=/dev/zero of=/swapfile
sudo chmod 0600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

echo
echo 'finished successfully'

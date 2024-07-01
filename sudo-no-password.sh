#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/${USER}"

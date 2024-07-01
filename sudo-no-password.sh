#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/${USER}"

sudo mkdir --parents /var/lib/polkit-1/localauthority/50-local.d
POLKIT_FILE=/var/lib/polkit-1/localauthority/50-local.d/10-disable-password-prompt.pkla
echo '[Disable password prompt]'  | sudo tee          "${POLKIT_FILE}"
echo "Identity=unix-user:${USER}" | sudo tee --append "${POLKIT_FILE}"
echo 'Action=*'                   | sudo tee --append "${POLKIT_FILE}"
echo 'ResultAny=yes'              | sudo tee --append "${POLKIT_FILE}"

echo 'done'

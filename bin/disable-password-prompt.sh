#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

SUDOERS_FILE="/etc/sudoers.d/disable-password-prompt-${USER}"
echo "${USER} ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee "${SUDOERS_FILE}"
sudo chmod 440 "${SUDOERS_FILE}"

POLKIT_FILE='/etc/polkit-1/rules.d/10-disable-password-prompt.rules'
echo 'polkit.addRule(function (action, subject) {' | sudo tee          "${POLKIT_FILE}"
echo "  if (subject.user === \"${USER}\") {"       | sudo tee --append "${POLKIT_FILE}"
echo '    return polkit.Result.YES;'               | sudo tee --append "${POLKIT_FILE}"
echo '  }'                                         | sudo tee --append "${POLKIT_FILE}"
echo '});'                                         | sudo tee --append "${POLKIT_FILE}"
sudo chmod 440 "${POLKIT_FILE}"

echo 'done'

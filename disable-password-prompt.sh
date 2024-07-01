#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/${USER}"

POLKIT_FILE='/etc/polkit-1/rules.d/10-disable-password-prompt.rules'
echo 'polkit.addRule(function (action, subject) {' | sudo tee          "${POLKIT_FILE}"
echo "  if (subject.user === \"${USER}\") {"       | sudo tee --append "${POLKIT_FILE}"
echo '    return polkit.Result.YES;'               | sudo tee --append "${POLKIT_FILE}"
echo '  }'                                         | sudo tee --append "${POLKIT_FILE}"
echo '});'                                         | sudo tee --append "${POLKIT_FILE}"

echo 'done'

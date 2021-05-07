#!/usr/bin/env bash

set -euxo pipefail

: ${MOONRAKER_REPO:="https://github.com/Arksine/moonraker"}
: ${MOONRAKER_PATH:="$1/moonraker"}
: ${MOONRAKER_VENV_PATH:="$1/venv/moonraker"}

if [ $(id -u) = 0 ]; then
    echo "This script must not run as root"
    exit 1
fi

[ -d ${MOONRAKER_PATH} ] || git clone ${MOONRAKER_REPO} ${MOONRAKER_PATH}
virtualenv -p python3 $MOONRAKER_VENV_PATH

patch ${MOONRAKER_PATH}/moonraker/components/update_manager.py update-mgr.patch

${MOONRAKER_VENV_PATH}/bin/python -m pip install --upgrade pip
${MOONRAKER_VENV_PATH}/bin/pip install -r ${MOONRAKER_PATH}/scripts/moonraker-requirements.txt

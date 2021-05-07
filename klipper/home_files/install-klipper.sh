#!/usr/bin/env sh

set -euxo pipefail

: ${KLIPPER_HOME:="$1"}
: ${KLIPPY_VENV_PATH:="${KLIPPER_HOME}/venv/klippy"}
: ${KLIPPER_REPO:="https://github.com/KevinOConnor/klipper.git"}

if [ $(id -u) = 0 ]; then
    echo "This script must not run as root"
    exit 1
fi

[ -d ${KLIPPY_VENV_PATH} ] || rm -rf  ${KLIPPY_VENV_PATH}
[ -d ${KLIPPER_HOME}/klipper ] || rm -rf ${KLIPPER_HOME}/klipper

git clone ${KLIPPER_REPO} ${KLIPPER_HOME}/klipper
virtualenv -p python2 ${KLIPPER_HOME}/venv/klippy
${KLIPPER_HOME}/venv/klippy/bin/python -m pip install --upgrade pip
${KLIPPER_HOME}/venv/klippy/bin/pip install -r ${KLIPPER_HOME}/klipper/scripts/klippy-requirements.txt

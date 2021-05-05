#!/usr/bin/env bash

set -euxo pipefail

: ${KLIPPER_REPO:="https://github.com/KevinOConnor/klipper.git"}
: ${KLIPPER_PATH:="$HOME/klipper"}
: ${KLIPPY_VENV_PATH:="$HOME/venv/klippy"}
: ${KLIPPER_PKGS:="alpine-sdk git python2 python2-dev python3 py3-virtualenv libffi-dev"}

if [ $(id -u) = 0 ]; then
    echo "This script must not run as root"
    exit 1
fi

mkdir -p ${KLIPPER_CONFIG_PATH} ${GCODE_PATH}
rm -rf $HOME/venv
rm -rf $HOME/klipper

sudo apk add --update ${KLIPPER_PKGS}

git clone $KLIPPER_REPO $HOME/klipper
virtualenv -p python2 $HOME/venv/klippy
$HOME/venv/klippy/bin/python -m pip install --upgrade pip
$HOME/venv/klippy/bin/pip install -r $HOME/klipper/scripts/klippy-requirements.txt

#!/usr/bin/env bash

set -euxo pipefail

: ${MOONRAKER_REPO:="https://github.com/Arksine/moonraker"}
: ${MOONRAKER_PATH:="${KLIPPER_HOME}/moonraker"}
: ${MOONRAKER_VENV_PATH:="${KLIPPER_HOME}/venv/moonraker"}
: ${MOORAKER_PKGS="rsync patch python3-dev py3-libgpiod zlib-dev jpeg-dev"}

if [ $(id -u) = 0 ]; then
    echo "This script must not run as root"
    exit 1
fi

sudo apk add --update ${MOORAKER_PKGS}

test -d ${MOONRAKER_PATH} || git clone ${MOONRAKER_REPO} ${MOONRAKER_PATH}
virtualenv -p python3 $MOONRAKER_VENV_PATH

# fix up directories for python dist-packages 
sed -i -E "1,/klipper/s|(python_dist_path: )(.*)|\1$(python3 -c "import site; print(site.getsitepackages()[0])")|" ${MOONRAKER_PATH}/scripts/update_manager.conf
sed -i -E "1,/klipper/!s|(python_dist_path: )(.*)|\1$(python2 -c "import site; print(site.getsitepackages()[0])")|" ${MOONRAKER_PATH}/scripts/update_manager.conf
# ln -s $(python3 -c "import site; print(site.getsitepackages()[0])")/gpiod* ${MOONRAKER_VENV_PATH}/lib/python*/site-packages

${MOONRAKER_VENV_PATH}/bin/python -m pip install --upgrade pip
${MOONRAKER_VENV_PATH}/bin/pip install -r ${MOONRAKER_PATH}/scripts/moonraker-requirements.txt

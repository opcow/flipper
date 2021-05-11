#!/bin/bash

[[ -d /home/moonraker ]] || sudo mkdir /home/moonraker && sudo chown moonraker:moonraker /home/moonraker
[[ -f /home/moonraker/moonraker.conf ]] || sudo tar -xzf /usr/share/moonraker/home.tar.gz -C /home/moonraker
[ -f "/config/moonraker.conf" ] || cp -p /home/moonraker/moonraker.conf /config

# sudo apt update
# sudo apt -y dist-upgrade
# sudo apt -y autoremove
# sudo apt clean
# sudo apt purge -y $(dpkg -l | awk '/^rc/ { print $2 }')

exec "$@"
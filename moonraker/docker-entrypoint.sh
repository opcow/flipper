#!/bin/sh
if [ ! -f "/config/moonraker.conf" ]; then
  sudo chmod 777 /config
  cp /opt/moonraker/moonraker.conf /config
fi
exec /opt/moonraker/run-moonraker.sh

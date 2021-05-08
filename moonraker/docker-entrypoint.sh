#!/bin/sh
[ -f "/config/moonraker.conf" ] || cp /opt/moonraker/moonraker.conf /config
exec /opt/moonraker/run-moonraker.sh

#!/bin/sh
[ -f "/config/moonraker.conf" ] || cp  /home/moonraker/moonraker.conf /config/
exec /home/moonraker/run-moonraker.sh

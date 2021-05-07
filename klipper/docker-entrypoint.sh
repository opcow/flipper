#!/bin/sh
[ -f "/config/printer.cfg" ] || cp /home/klipper/printer.cfg /config/
[ -f "/config/macros.cfg" ] || cp /home/klipper/macros.cfg /config/
exec /home/klipper/run-klipper.sh

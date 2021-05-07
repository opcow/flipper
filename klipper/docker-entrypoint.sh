#!/bin/sh
[ -f "/config/printer.cfg" ] || sudo cp /opt/klipper/printer.cfg /config/
[ -f "/config/macros.cfg" ] || sudo cp /opt/klipper/macros.cfg /config/
exec /opt/klipper/run-klipper.sh

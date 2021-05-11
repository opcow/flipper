#!/bin/sh
# [ -f "/config/printer.cfg" ] || cp /opt/klipper/printer.cfg /config/
# [ -f "/config/macros.cfg" ] || cp /opt/klipper/macros.cfg /config/

exec ${KLIPPY_ENV}/bin/python ${KLIPPER_HOME}/klipper/klippy/klippy.py ${CONFIG_PATH}/printer.cfg -l /tmp/klippy.log -a /tmp/klippy_uds &
exec ${MOONRAKER_ENV}/bin/python ${KLIPPER_HOME}/moonraker/moonraker/moonraker.py -c ${CONFIG_PATH}/moonraker.conf

# exec "$@"
########
FROM alpine:latest

ENV KLIPPER_USER=klipper
ENV KLIPPER_USER_PASSWD=klipper
ENV KLIPPER_HOME=/home/${KLIPPER_USER}
ENV CONFIG_DIR=klipper_config
ENV KLIPPER_CONFIG_PATH=${KLIPPER_HOME}/${CONFIG_DIR}
ENV GCODE_PATH=${KLIPPER_HOME}/gcode
ENV PRITNER_PORT=/dev/serial/by-id/usb-Klipper_lpc1769_20F0FF0B28813AAF13826A5CC02000F5-if00

###### setup user ######
RUN apk add --update sudo bash

RUN adduser ${KLIPPER_USER} -D -h ${KLIPPER_HOME}
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel
RUN adduser ${KLIPPER_USER} wheel
COPY --chown=${KLIPPER_USER}:${KLIPPER_USER} ./install-*.sh ${KLIPPER_HOME}/
RUN chmod +x ${KLIPPER_HOME}/*.sh
########################

WORKDIR ${KLIPPER_HOME}
SHELL [ "/bin/bash", "-c" ]
###### setup klipper ######
RUN sed -i -e 's|${KLIPPER_CONFIG_PATH}|'${KLIPPER_CONFIG_PATH}'|' install-klipper.sh
RUN sed -i -e 's|${GCODE_PATH}|'${GCODE_PATH}'|' install-klipper.sh
RUN su klipper -c ./install-klipper.sh
RUN printf $"#!/bin/bash\n${KLIPPER_HOME}/venv/klippy/bin/python ${KLIPPER_HOME}/klipper/klippy/klippy.py ${KLIPPER_CONFIG_PATH}/printer.cfg -l /tmp/klippy.log -a /tmp/klippy_uds\n" > run-klipper.sh
RUN chmod +x run-klipper.sh
###########################

###### setup moonraker ######
RUN sed -i -e 's|${KLIPPER_HOME}|'${KLIPPER_HOME}'|g' install-moonraker.sh
RUN sed -i -e 's|${KLIPPER_CONFIG_PATH}|'${KLIPPER_CONFIG_PATH}'|g' install-moonraker.sh
RUN su - klipper -c ./install-moonraker.sh
RUN printf "#!/bin/sh\n${KLIPPER_HOME}/venv/moonraker/bin/python ${KLIPPER_HOME}/moonraker/moonraker/moonraker.py -c ${KLIPPER_CONFIG_PATH}/moonraker.conf" > run-moonraker.sh
RUN chmod +x run-moonraker.sh
#############################

# RUN apt-get install -y -q procps net-tools nano

COPY --chown=${KLIPPER_USER}:${KLIPPER_USER} ./klipper_config ${CONFIG_DIR}
RUN sed -i -e "s|serial: <serial-dev>|serial: ${PRITNER_PORT}|" ${CONFIG_DIR}/printer.cfg
RUN sed -i -E 's|(config_path: )(.*)$|\1'${KLIPPER_CONFIG_PATH}'|' ${CONFIG_DIR}/moonraker.conf
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 7125
WORKDIR /

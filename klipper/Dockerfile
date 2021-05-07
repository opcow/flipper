FROM alpine:latest

ENV KLIPPER_USER=klipper
ENV KLIPPER_HOME=/home/${KLIPPER_USER}
ENV GCODE_PATH=${KLIPPER_HOME}/gcode

RUN apk add --update sudo bash git alpine-sdk python3-dev python3 py3-virtualenv python2 python2-dev libffi-dev
###### setup user ######
RUN adduser ${KLIPPER_USER} -D -h ${KLIPPER_HOME}
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel
RUN adduser ${KLIPPER_USER} wheel
COPY --chown=${KLIPPER_USER}:${KLIPPER_USER} ./home_files ${KLIPPER_HOME}
RUN chmod +x ${KLIPPER_HOME}/install-klipper.sh
########################

WORKDIR ${KLIPPER_HOME}
SHELL [ "/bin/bash", "-c" ]
###### setup klipper ######
RUN su klipper -c "./install-klipper.sh ${KLIPPER_HOME}"
RUN printf $"#!/bin/bash\n${KLIPPER_HOME}/venv/klippy/bin/python ${KLIPPER_HOME}/klipper/klippy/klippy.py /config/printer.cfg -l /tmp/klippy.log -a /tmp/klippy_uds\n" > run-klipper.sh
RUN chmod +x run-klipper.sh
###########################

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 7125
WORKDIR /
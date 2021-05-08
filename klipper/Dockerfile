FROM alpine:latest

ENV KLIPPER_USER=klipper
ENV KLIPPER_HOME=/opt/${KLIPPER_USER}
ENV GCODE_PATH=${KLIPPER_HOME}/gcode
ENV KLIPPER_REPO=https://github.com/KevinOConnor/klipper.git

RUN apk add --update bash git alpine-sdk python2 python2-dev libffi-dev
RUN python -m ensurepip --default-pip
RUN python -m pip install --upgrade pip

###### setup user ######
RUN adduser ${KLIPPER_USER} -D
USER klipper
WORKDIR ${KLIPPER_HOME}
RUN git clone ${KLIPPER_REPO} klipper
###### setup klipper ######
COPY --chown=${KLIPPER_USER}:${KLIPPER_USER} ./home_files ${KLIPPER_HOME}
RUN python -m pip install -r ${KLIPPER_HOME}/klipper/scripts/klippy-requirements.txt
RUN printf "#!/bin/bash\npython ${KLIPPER_HOME}/klipper/klippy/klippy.py /config/printer.cfg -l /tmp/klippy.log -a /tmp/klippy_uds\n" > run-klipper.sh
RUN chmod +x run-klipper.sh
###########################

USER root
RUN mkdir /config
RUN chown ${KLIPPER_USER}:${KLIPPER_USER} /config
RUN mkdir /gcode
RUN chown ${KLIPPER_USER}:${KLIPPER_USER} /gcode
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 7125
WORKDIR /
USER klipper

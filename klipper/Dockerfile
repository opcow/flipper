FROM debian:buster-slim

ENV KLIPPER_USER=klipper
ENV KLIPPER_HOME=/home/${KLIPPER_USER}
ENV CONFIG_PATH=/config
ENV GCODE_PATH=/gcode
ENV KLIPPER_REPO=https://github.com/KevinOConnor/klipper.git
ENV PKGLIST="git python-dev python-pip libffi-dev build-essential"
ENV PYTHONDIR="${KLIPPER_HOME}/klippy-env"

RUN apt-get update
RUN apt-get install -y -q sudo

###### setup user ######
SHELL [ "bash", "-c" ]
RUN adduser --disabled-password --gecos "" ${KLIPPER_USER}
RUN chpasswd <<<"${KLIPPER_USER}:render"
RUN sudo usermod -a -G sudo ${KLIPPER_USER}
RUN echo "${KLIPPER_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${KLIPPER_USER}

###### setup klipper ######
USER ${KLIPPER_USER}
WORKDIR ${KLIPPER_HOME}
RUN sudo apt-get install -y -q git && git clone ${KLIPPER_REPO} klipper

RUN sudo apt-get install -y -q virtualenv python-dev build-essential libffi-dev
RUN virtualenv -p python2 ${PYTHONDIR}
RUN ${PYTHONDIR}/bin/pip install -r ${KLIPPER_HOME}/klipper/scripts/klippy-requirements.txt

# ###### create data directories ######
USER root
RUN mkdir /config
RUN chown ${KLIPPER_USER}:${KLIPPER_USER} ${CONFIG_PATH}
COPY --chown=${KLIPPER_USER}:${KLIPPER_USER} ./config_files ${CONFIG_PATH}/

RUN mkdir ${GCODE_PATH}
RUN chown ${KLIPPER_USER}:${KLIPPER_USER} ${GCODE_PATH}
# ###### entrypoint ######
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ${PYTHONDIR}/bin/python ${KLIPPER_HOME}/klipper/klippy/klippy.py ${CONFIG_PATH}/printer.cfg -l /tmp/klippy.log -a /tmp/klippy_uds

USER ${KLIPPER_USER}

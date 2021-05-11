FROM debian:buster-slim

ENV KLIPPER_USER=klipper
ENV KLIPPER_HOME=/home/${KLIPPER_USER}
ENV CONFIG_PATH=config
ENV GCODE_PATH=gcode
ENV KLIPPER_REPO=https://github.com/KevinOConnor/klipper.git
ENV MOONRAKER_REPO=https://github.com/Arksine/moonraker
ENV PKGLIST="git python-dev python-pip libffi-dev build-essential"
ENV KLIPPY_ENV="${KLIPPER_HOME}/klippy-env"
ENV MOONRAKER_ENV="${KLIPPER_HOME}/moonraker-env"

RUN apt-get update
RUN apt-get install -y -q sudo

###### setup user ######
SHELL [ "bash", "-c" ]
RUN adduser --disabled-password --gecos "" ${KLIPPER_USER}
RUN chpasswd <<<"${KLIPPER_USER}:render"
RUN sudo usermod -a -G sudo ${KLIPPER_USER}
RUN echo "${KLIPPER_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${KLIPPER_USER}

RUN apt-get install -y -q git virtualenv rsync

USER ${KLIPPER_USER}
WORKDIR ${KLIPPER_HOME}

###### setup klipper ######
RUN git clone ${KLIPPER_REPO} klipper
RUN sudo apt-get install -y -q virtualenv python-dev build-essential libffi-dev
RUN virtualenv -p python2 ${KLIPPY_ENV}
RUN ${KLIPPY_ENV}/bin/pip install -r ${KLIPPER_HOME}/klipper/scripts/klippy-requirements.txt

###### setup moonraker ######
RUN git clone ${MOONRAKER_REPO} moonraker
RUN virtualenv -p /usr/bin/python3 ${MOONRAKER_ENV}
RUN ln -s /usr/lib/python3/dist-packages/gpiod* ${MOONRAKER_ENV}/lib/python*/site-packages
RUN ${MOONRAKER_ENV}/bin/pip install -r ${KLIPPER_HOME}/moonraker/scripts/moonraker-requirements.txt

# ###### create data directories ######
RUN mkdir ${CONFIG_PATH} ${GCODE_PATH}
COPY --chown=${KLIPPER_USER}:${KLIPPER_USER} ./config_files ${CONFIG_PATH}/

# RUN chown ${KLIPPER_USER}:${KLIPPER_USER} ${GCODE_PATH}
USER root
# # ###### entrypoint ######
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ${KLIPPY_ENV}/bin/python ${KLIPPER_HOME}/klipper/klippy/klippy.py ${CONFIG_PATH}/printer.cfg -l /tmp/klippy.log -a /tmp/klippy_uds

USER ${KLIPPER_USER}
EXPOSE 7125

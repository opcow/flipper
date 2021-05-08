FROM alpine:latest

ENV MOONRAKER_USER=moonraker
ENV MOONRAKER_HOME=/opt/${MOONRAKER_USER}
ENV CONFIG_PATH=/config
ENV MOONRAKER_REPO=https://github.com/Arksine/moonraker


RUN apk add --update bash git rsync patch python3-dev py3-pip py3-libgpiod zlib-dev jpeg-dev gcc musl-dev
RUN ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

###### setup user ######
RUN adduser ${MOONRAKER_USER} -D
USER moonraker
WORKDIR ${MOONRAKER_HOME}
###### setup moonraker ######
RUN git clone ${MOONRAKER_REPO} moonraker
RUN pip3 install --upgrade pip
RUN pip3 install --no-use-pep517 -r ${MOONRAKER_HOME}/moonraker/scripts/moonraker-requirements.txt
RUN printf "#!/bin/sh\npython ${MOONRAKER_HOME}/moonraker/moonraker/moonraker.py -c ${CONFIG_PATH}/moonraker.conf\n" > ${MOONRAKER_HOME}/run-moonraker.sh
RUN chmod +x run-moonraker.sh
###### patch update manager ######
COPY --chown=${MOONRAKER_USER}:${MOONRAKER_USER} ./update-mgr.patch ./
RUN patch ${MOONRAKER_HOME}/moonraker/moonraker/components/update_manager.py update-mgr.patch

USER root
RUN mkdir /config
COPY --chown=${MOONRAKER_USER}:${MOONRAKER_USER} ./moonraker.conf /config
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 7125
WORKDIR /
USER moonraker

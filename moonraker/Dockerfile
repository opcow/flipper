FROM alpine:latest

ENV MOONRAKER_USER=moonraker
ENV MOONRAKER_HOME=/opt/${MOONRAKER_USER}
ENV CONFIG_PATH=/config

RUN apk add --update bash git alpine-sdk rsync patch python3-dev py3-virtualenv py3-libgpiod zlib-dev jpeg-dev
###### setup user ######
RUN adduser ${MOONRAKER_USER} -D
########################

USER moonraker
WORKDIR ${MOONRAKER_HOME}

###### setup moonraker ######
COPY --chown=${MOONRAKER_USER}:${MOONRAKER_USER} ./install-moonraker.sh ./
RUN chmod +x install-moonraker.sh
COPY --chown=${MOONRAKER_USER}:${MOONRAKER_USER} ./update-mgr.patch ./
RUN ./install-moonraker.sh ${MOONRAKER_HOME}
RUN printf "#!/bin/sh\n${MOONRAKER_HOME}/venv/moonraker/bin/python ${MOONRAKER_HOME}/moonraker/moonraker/moonraker.py -c ${CONFIG_PATH}/moonraker.conf\n" > ${MOONRAKER_HOME}/run-moonraker.sh
RUN chmod +x run-moonraker.sh
#############################

COPY --chown=${MOONRAKER_USER}:${MOONRAKER_USER} ./moonraker.conf ./
RUN sed -i -E 's|(config_path: )(.*)|\1'${CONFIG_PATH}'|' ./moonraker.conf

USER root
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 7125
WORKDIR /
USER moonraker

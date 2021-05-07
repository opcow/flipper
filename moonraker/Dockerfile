FROM alpine:latest

ENV MOONRAKER_USER=moonraker
ENV MOONRAKER_HOME=/opt/${MOONRAKER_USER}
ENV CONFIG_PATH=/config

###### setup user ######
RUN apk add --update sudo bash git alpine-sdk rsync patch python3-dev py3-virtualenv py3-libgpiod zlib-dev jpeg-dev
RUN adduser ${MOONRAKER_USER} -D
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel
RUN adduser ${MOONRAKER_USER} wheel
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
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN sudo chmod +x /docker-entrypoint.sh

EXPOSE 7125
WORKDIR /

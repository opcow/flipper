FROM alpine:latest

ENV MOONRAKER_USER=moonraker
ENV MOONRAKER_HOME=/home/${MOONRAKER_USER}
ENV CONFIG_PATH=/config

###### setup user ######
RUN apk add --update sudo bash git alpine-sdk rsync patch python3-dev py3-virtualenv py3-libgpiod zlib-dev jpeg-dev
RUN adduser ${MOONRAKER_USER} -D -h ${MOONRAKER_HOME}
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel
RUN adduser ${MOONRAKER_USER} wheel
########################

WORKDIR ${MOONRAKER_HOME}
SHELL [ "/bin/bash", "-c" ]
###### setup moonraker ######
COPY --chown=${MOONRAKER_USER}:${MOONRAKER_USER} ./install-moonraker.sh ./
RUN chmod +x install-moonraker.sh
COPY --chown=${MOONRAKER_USER}:${MOONRAKER_USER} ./update-mgr.patch ./
RUN su - moonraker -c "./install-moonraker.sh ${MOONRAKER_HOME}"
RUN printf "#!/bin/sh\n${MOONRAKER_HOME}/venv/moonraker/bin/python ${MOONRAKER_HOME}/moonraker/moonraker/moonraker.py -c ${CONFIG_PATH}/moonraker.conf\n" > run-moonraker.sh
RUN chmod +x run-moonraker.sh
#############################

COPY --chown=${MOONRAKER_USER}:${MOONRAKER_USER} ./moonraker.conf ./
RUN sed -i -E 's|(config_path: )(.*)|\1'${CONFIG_PATH}'|' ./moonraker.conf
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 7125
WORKDIR /

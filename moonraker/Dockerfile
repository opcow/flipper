FROM debian:buster-slim

ENV MOONRAKER_USER=moonraker
ENV MOONRAKER_HOME=/home/${MOONRAKER_USER}
ENV CONFIG_PATH=/config
ENV MOONRAKER_REPO=https://github.com/Arksine/moonraker
ENV PKGLIST="python3-virtualenv python3-dev nginx libopenjp2-7 python3-libgpiod liblmdb0 rsync zlib1g-dev"
ENV PYTHONDIR="${MOONRAKER_HOME}/moonraker-env"

###### setup user ######
RUN apt-get update
RUN apt-get install -y -q sudo nano
SHELL [ "bash", "-c" ]
RUN adduser --disabled-password --gecos "" ${MOONRAKER_USER}
RUN chpasswd <<<"${MOONRAKER_USER}:render"
RUN sudo usermod -a -G sudo ${MOONRAKER_USER}
RUN echo "${MOONRAKER_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${MOONRAKER_USER}

###### setup moonraker ######
USER ${MOONRAKER_USER}
WORKDIR ${MOONRAKER_HOME}
RUN sudo apt-get install -y -q git && git clone ${MOONRAKER_REPO} moonraker

RUN sudo apt-get install -q -y rsync virtualenv && virtualenv -p /usr/bin/python3 ${PYTHONDIR}
RUN ln -s /usr/lib/python3/dist-packages/gpiod* ${PYTHONDIR}/lib/python*/site-packages
RUN ${PYTHONDIR}/bin/pip install -r ${MOONRAKER_HOME}/moonraker/scripts/moonraker-requirements.txt
COPY --chown=${MOONRAKER_USER}:${MOONRAKER_USER} ./moonraker.conf ./

USER root
RUN mkdir ${CONFIG_PATH} && chown ${MOONRAKER_USER}:${MOONRAKER_USER} ${CONFIG_PATH}
RUN mkdir /usr/share/moonraker && cd ${MOONRAKER_HOME} && tar -czvf /usr/share/moonraker/home.tar.gz ./ && rm -rf ${MOONRAKER_HOME}

# ###### entrypoint ######
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ${PYTHONDIR}/bin/python ${MOONRAKER_HOME}/moonraker/moonraker/moonraker.py -c ${CONFIG_PATH}/moonraker.conf

USER ${MOONRAKER_USER}
EXPOSE 7125

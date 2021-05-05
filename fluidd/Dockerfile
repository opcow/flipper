FROM cadriel/fluidd

ENV SETUPSTREAMS_SCRIPT=99-set-upstreams.sh

COPY ./common_vars.conf /etc/nginx/conf.d
COPY ./upstreams.conf /etc/nginx/conf.d
COPY ./default.conf /etc/nginx/conf.d
COPY ./nginx.conf /etc/nginx

RUN printf '#!/bin/sh\n \
if [[ -z "${DEPLOY_ENV}" ]]; then\n \
sed -i -e "s|server <UPSTREAM>;|server 0.0.0.0:7125;|" /etc/nginx/conf.d/upstreams.conf\n \
else\n \
sed -i -e "s|server <UPSTREAM>;|server ${UPSTREAM};|" /etc/nginx/conf.d/upstreams.conf\n \
fi\n' \
> /docker-entrypoint.d/${SETUPSTREAMS_SCRIPT}

RUN chmod +x /docker-entrypoint.d/${SETUPSTREAMS_SCRIPT}
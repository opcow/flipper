FROM cadriel/fluidd

COPY ./common_vars.conf /etc/nginx/conf.d
COPY ./upstreams.conf /etc/nginx/conf.d
COPY ./nginx.conf /etc/nginx
# COPY ./html /usr/share/nginx/html

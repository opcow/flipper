FROM cadriel/fluidd

COPY ./etc_nginx/conf.d /etc/nginx/conf.d
COPY ./etc_nginx/nginx.conf /etc/nginx
# COPY ./html /usr/share/nginx/html

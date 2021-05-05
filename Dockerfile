FROM nginx:stable-alpine

COPY ./etc_nginx/conf.d /etc/nginx/conf.d
COPY ./etc_nginx/nginx.conf /etc/nginx
# COPY ./etc_nginx/default.conf /etc/nginx
COPY ./share_nginx/html /usr/share/nginx/html
# RUN rm /etc/nginx/default.conf
###### setup nginx ######
# COPY ./nginx-conf.d /etc/nginx/conf.d
# COPY ./default.conf /etc/nginx/
# RUN rm /usr/share/nginx/html/*
# COPY ./html/ /usr/share/nginx/html
#########################

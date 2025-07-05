FROM alpine:latest

USER root

RUN apk update && \
    apk add nginx && \
    chown -R nginx:www-data /var/lib/nginx

WORKDIR /etc/nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY docker/ /var/lib/nginx/html/

RUN chmod -R 755 /var/lib/nginx

EXPOSE 8080
CMD ["/usr/sbin/nginx"]

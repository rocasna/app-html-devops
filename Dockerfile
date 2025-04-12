FROM nginx:stable-alpine3.20-slim

ENV DOCKER_CONTENT_TRUST=1

COPY ./app/index.html /usr/share/nginx/html/
COPY ./app/favicon.ico /usr/share/nginx/html/

RUN mkdir -p /var/cache/nginx/client_temp && \
    chown -R nginx:nginx /var/cache/nginx

RUN adduser -D -h /bin/bash github_action
USER github_action

HEALTHCHECK CMD curl --fail http://localhost/ || exit 1
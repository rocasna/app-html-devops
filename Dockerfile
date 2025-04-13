FROM nginx:stable-alpine3.20-slim

ENV DOCKER_CONTENT_TRUST=1

COPY ./app/* /usr/share/nginx/html/

RUN addgroup -g 1000 github_action \
    && adduser -u 1000 -G github_action -s /sbin/nologin -D github_action

RUN chown -R github_action:github_action /var/cache/nginx \
    && chown -R github_action:github_action /var/log/nginx \
    && chown -R github_action:github_action /etc/nginx/conf.d \
    && touch /var/run/nginx.pid \
    && chown -R github_action:github_action /var/run/nginx.pid

USER github_action

HEALTHCHECK CMD curl --fail http://localhost/ || exit 1

ENTRYPOINT ["nginx", "-g", "daemon off;"]
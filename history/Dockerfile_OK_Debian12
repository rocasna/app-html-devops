FROM nginx:stable-bookworm-perl

ENV DOCKER_CONTENT_TRUST=1

COPY ./app/index.html /usr/share/nginx/html/
COPY ./app/favicon.ico /usr/share/nginx/html/

RUN adduser --system --uid 1000 --no-create-home --disabled-login --group github_action

RUN chown -R github_action:github_action /var/cache/nginx \
    && chown -R github_action:github_action /var/log/nginx \
    && chown -R github_action:github_action /etc/nginx/conf.d \
    && touch /var/run/nginx.pid \
    && chown -R github_action:github_action /var/run/nginx.pid

USER github_action

HEALTHCHECK CMD curl --fail http://localhost/ || exit 1

ENTRYPOINT ["nginx", "-g", "daemon off;"]
FROM nginx:stable-alpine3.20-slim

ENV DOCKER_CONTENT_TRUST=1

# Copiar archivos
COPY ./app/index.html /usr/share/nginx/html/
COPY ./app/favicon.ico /usr/share/nginx/html/

# Crear directorios de cache y asignar permisos
RUN mkdir -p /var/cache/nginx/client_temp /var/cache/nginx/proxy_temp && \
    chown -R nginx:nginx /var/cache/nginx

# Crear usuario no-root
RUN adduser -D -h /bin/bash github_action

# Cambiar a usuario no-root
#USER github_action

# Configurar la comprobación de salud
HEALTHCHECK CMD curl --fail http://localhost/ || exit 1

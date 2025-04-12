FROM nginx:stable-alpine3.20-slim

ENV DOCKER_CONTENT_TRUST=1

# Copiar archivos
COPY ./app/index.html /usr/share/nginx/html/
COPY ./app/favicon.ico /usr/share/nginx/html/

# Crear los directorios de caché necesarios y dar permisos
RUN mkdir -p /var/cache/nginx/client_temp /var/cache/nginx/proxy_temp /var/cache/nginx/fastcgi_temp /var/cache/nginx/scgi_temp && \
    chown -R nginx:nginx /var/cache/nginx && \
    chmod -R 755 /var/cache/nginx

# Asegurarse de que nginx tenga permisos en /etc/nginx
RUN chown -R nginx:nginx /etc/nginx && \
    chmod -R 755 /etc/nginx

# Ejecutar como root para evitar problemas de permisos con directorios del sistema
USER root

# Configurar la comprobación de salud
HEALTHCHECK CMD curl --fail http://localhost/ || exit 1

# Eliminar la directiva 'user' en nginx.conf
RUN sed -i '/^user/d' /etc/nginx/nginx.conf

FROM nginx:1.27.4

COPY ./app/index.html /usr/share/nginx/html/
COPY ./app/favicon.ico /usr/share/nginx/html/
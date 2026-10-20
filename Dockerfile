FROM nginx:1.27-alpine

COPY index.html /usr/share/nginx/html/index.html
COPY nginx-conf/default.conf /etc/nginx/conf.d/default.conf

RUN nginx -t

STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]

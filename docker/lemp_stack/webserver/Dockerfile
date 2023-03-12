FROM nginx:1.23.3-alpine

# copy the nginx configuration and scripts - the path is relative to the docker-compose.yml and not the dockerfile
COPY ./webserver/nginx-conf /etc/nginx/conf.d
COPY ./webserver/scripts /app/scripts

RUN chmod 0755 /app/scripts/enable_ssl_and_https.sh
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.old

# expose the port for the web server
EXPOSE 80
EXPOSE 443

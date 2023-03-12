#!/bin/sh

/bin/mv /etc/nginx/conf.d/nginx.conf /etc/nginx/conf.d/nginx.conf.old
/bin/mv /etc/nginx/conf.d/nginx-https.conf.new /etc/nginx/conf.d/nginx-https.conf
/usr/sbin/nginx -s reload

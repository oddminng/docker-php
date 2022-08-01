#!/bin/bash

chmod -R 777 /usr/share/nginx/html/example-app/storage
chmod -R 777 /usr/share/nginx/html/example-app/bootstrap/cache

touch /usr/share/nginx/html/example-app/storage/logs/horizon.log

service cron start
service supervisor start
crontab /etc/cron.d/php-cron

/usr/local/sbin/php-fpm
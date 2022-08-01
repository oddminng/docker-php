FROM redis:7.0.4-bullseye

COPY ./redis_config/redis.conf /usr/local/etc/redis/redis.conf

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
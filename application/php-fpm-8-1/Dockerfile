FROM php:8.1.8-fpm-bullseye

ENV TZ=Asia/Shanghai

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
        && touch /etc/apt/sources.list \
        && echo "deb http://mirrors.aliyun.com/debian/ bullseye main non-free contrib" >> /etc/apt/sources.list \
        && echo "deb-src http://mirrors.aliyun.com/debian/ bullseye main non-free contrib" >> /etc/apt/sources.list \
        && echo "deb http://mirrors.aliyun.com/debian-security/ bullseye-security main" >> /etc/apt/sources.list \
        && echo "deb-src http://mirrors.aliyun.com/debian-security/ bullseye-security main" >> /etc/apt/sources.list \
        && echo "deb http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib" >> /etc/apt/sources.list \
        && echo "deb-src http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib" >> /etc/apt/sources.list \
        && echo "deb http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib" >> /etc/apt/sources.list \
        && echo "deb-src http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib" >> /etc/apt/sources.list \
        && cat /etc/apt/sources.list.bak >> /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y zip unzip

RUN php -r "readfile('https://install.phpcomposer.com/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

# ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# RUN chmod +x /usr/local/bin/install-php-extensions && \
#     install-php-extensions \
#     bcmath \
#     gd \
#     xdebug

RUN docker-php-ext-install -j$(nproc) \
		pcntl \
                bcmath

RUN pecl install redis \
    && docker-php-ext-enable redis

RUN apt-get install -y cron supervisor

COPY ./crontab_files /etc/cron.d/
RUN touch /var/log/cron.log

ADD ./supervisor_config/supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir /var/log/supervisord
RUN touch /var/log/supervisord/supervisord_serviceadmin.log

ADD ./start_php_fpm.sh /docker/start.sh
RUN chmod +x /docker/start.sh

CMD ["/docker/start.sh"]
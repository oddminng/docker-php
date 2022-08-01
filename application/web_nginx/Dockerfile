# Nginx Server
FROM debian:bullseye

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

RUN apt-get update \
	&& apt-get install -y \
		nginx cron logrotate

RUN rm -f /etc/nginx/sites-enabled/default

COPY logrotate_conf/nginx /etc/logrotate.d/

ADD ./start_nginx.sh /docker/start.sh
RUN chmod +x /docker/start.sh

CMD ["/docker/start.sh"]

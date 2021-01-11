FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y gnupg tzdata \
    && echo "Europe/Berlin" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata
RUN apt update -yqq && apt install -yqq supervisor php-fpm
RUN apt install -yqq php-mysql php-xml php-zip php-intl php-zip php-mbstring libapache2-mod-php php-gd imagemagick php-imagick composer php-gearman php-redis php-pgsql php-amqp
EXPOSE 9000
COPY php-fpm.conf /etc/php/7.4/fpm/
COPY sv-php-fpm.conf /etc/supervisor/conf.d/
COPY www.conf /etc/php/7.4/fpm/pool.d/
RUN mkdir -p /var/www/html
VOLUME /var/www/html
CMD ["supervisord"]




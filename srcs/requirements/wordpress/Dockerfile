#On se base sur l'image docker debian.
FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y

RUN apt-get install -y php-fpm

COPY ./conf/wordpress_setup.sh /tmp/
RUN  chmod +x /tmp/wordpress_setup.sh

CMD ["sh", "/tmp/wordpress_setup.sh"]

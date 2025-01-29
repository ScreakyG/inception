#On se base sur l'image docker debian.
FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y

RUN apt install -y php-fpm
RUN apt install -y mariadb-client
RUN apt install -y php7.4-mysql

COPY ./conf/wordpress_setup.sh /tmp/
RUN  chmod +x /tmp/wordpress_setup.sh

CMD ["sh", "/tmp/wordpress_setup.sh"]

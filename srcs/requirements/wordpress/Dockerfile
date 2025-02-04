#On se base sur l'image docker debian.
FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y

RUN apt install -y php-fpm
RUN apt install -y mariadb-client
RUN apt install -y php7.4-mysql

#### WP-CLI INSTALLATION ####

RUN apt install -y curl
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
#Permet de simplement utiliser 'wp' au lieu de 'php wp-cli.phar' pour les commandes de la CLI
RUN mv wp-cli.phar /usr/local/bin/wp

#############################

COPY ./conf/wordpress_setup.sh /tmp/
RUN  chmod +x /tmp/wordpress_setup.sh

CMD ["sh", "/tmp/wordpress_setup.sh"]

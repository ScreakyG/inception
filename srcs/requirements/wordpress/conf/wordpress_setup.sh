#!/bin/bash

#Etait necessaire pour quand php ecoutait sur sa socket , peut etre plus utile maintenant.
if [ ! -d "/run/php" ]; then
    echo "[INFO] Creating /run/php.."
    mkdir /run/php
fi

#Permet de remplacer les lignes commencant par "listen = XXXXXXX" par "listen = wordpress:9000". Pour que php-fpm ecoute sur son port 9000.
sed -i 's/^listen = .*/listen = wordpress:9000/' /etc/php/7.4/fpm/pool.d/www.conf


### CHECK IF MARIADB IS UP ###

while ! mariadb -hmariadb -u$WP_USER -p$WP_PASSWORD $WP_DATABASE; #&>/dev/null;
do
    echo "[INFO] MariaDB unavailable, retrying.."
    sleep 5
done
echo "[INFO] MariaDB available"

### WORDPRESS INSTALL PART ###

if [ ! -f "/var/www/html/wp-config.php" ]
then
    echo "[INFO] Creating a new wordpress install.."
    wp core download --path=/var/www/html --allow-root #telecharge les fichiers d'installations de WP dans mon dossier.
    cd /var/www/html
    wp config create --dbhost=mariadb --dbname=$WP_DATABASE --dbuser=$WP_USER --dbpass=$WP_PASSWORD --allow-root #Connection a la Database MYSQL
    wp core install --url=https://$DOMAIN_NAME --title=$DOMAIN_NAME --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_MAIL --allow-root #Installation de wordpress
    wp user create $WP_USER2_NAME  $WP_USER2_MAIL --user_pass=$WP_USER2_PASS --allow-root #Creation d'un deuxieme user pour le sujet.
else
    echo "[INFO] Wordpress is already installed"
fi

cd /var/www/html
rm -rf index.nginx-debian.html

##############################


#Lance php-fpm en foreground (pas de daemonisation).
/usr/sbin/php-fpm7.4 -F

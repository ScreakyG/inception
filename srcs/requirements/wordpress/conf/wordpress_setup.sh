#!/bin/bash

echo "[INFO] Hello this is Wordpress setup script.."

#Etait necessaire pour quand php ecoutait sur sa socket , peut etre plus utile maintenant.
if [ ! -d "/run/php" ]; then
    echo "[INFO] Creating /run/php.."
    mkdir /run/php
fi

#Permet de remplacer les lignes commencant par "listen = XXXXXXX" par "listen = wordpress:9000". Pour que php-fpm ecoute sur son port 9000.
sed -i 's/^listen = .*/listen = wordpress:9000/' /etc/php/7.4/fpm/pool.d/www.conf


### WORDPRESS INSTALL PART ###

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar #Telecharge la CLI de WP
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp #Permet de simplement utiliser 'wp' au lieu de 'php wp-cli.phar' pour les commandes de la CLI

sleep 5 #on veut etre sur que la database est cree avant que wordpress try de se connect.

wp core download --path=/var/www/html --allow-root #telecharge les fichiers d'installations de WP dans mon dossier.
cd /var/www/html
rm -rf index.nginx-debian.html

wp config create --dbhost=mariadb --dbname=$WP_DATABASE --dbuser=$WP_USER --dbpass=$WP_PASSWORD --allow-root
wp core install --url=localhost --title="testinception" --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_MAIL --allow-root
wp user create $WP_USER2_NAME  $WP_USER2_MAIL --user_pass=$WP_USER2_PASS --allow-root
##############################


#Lance php-fpm en foreground (pas de daemonisation).
/usr/sbin/php-fpm7.4 -F

#!/bin/bash

echo "[INFO] Hello this is Wordpress setup script.."

#Etait necessaire pour quand php ecoutait sur sa socket , peut etre plus utile maintenant.
if [ ! -d "/run/php" ]; then
    echo "[INFO] Creating /run/php.."
    mkdir /run/php
fi

#Permet de remplacer les lignes commencant par "listen = XXXXXXX" par "listen = wordpress:9000". Pour que php-fpm ecoute sur son port 9000.
sed -i 's/^listen = .*/listen = wordpress:9000/' /etc/php/7.4/fpm/pool.d/www.conf



#Lance php-fpm en foreground (pas de daemonisation).
/usr/sbin/php-fpm7.4 -F

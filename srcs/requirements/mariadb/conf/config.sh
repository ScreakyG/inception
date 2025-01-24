#!/bin/bash

# Creation du dossier pour les fichiers temporaires de MariaDB (comme la socket par exemple).
if [ ! -d "/run/mysqld" ]; then
    echo "[INFO] Creating /run/mysqld/ and giving rights to mysql.."
    mkdir -p    /run/mysqld
    chown -R    mysql:mysql /run/mysqld
fi

#Creation du dossier qui permet de stocker les datas des databases (tables, indexs..), ce dossier sera persistant (dans le cas de crash on ne veut pas perdre les databases).
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "[INFO] Initiliazing MariaDB directories.."
    #Script qui initialise les tables systemes de MariaDB, --user=mysql pour specifier que les dossiers appartienent a cet user, --datadir pour l'endroit ou stocker les databases.
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    ###### Creation de l'USER et de la DATABASE

    mysqld --user=mysql --bootstrap << EOF

USE mysql;
FLUSH PRIVILEGES;

# # -- Sécurisation de l'utilisateur root
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

# Création de la base de données WordPress
CREATE DATABASE IF NOT EXISTS ${WP_DATABASE};

# Création de l'utilisateur WordPress
CREATE USER '${WP_USER}'@'%' IDENTIFIED BY '${WP_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WP_DATABASE}.* TO '${WP_USER}'@'%';

FLUSH PRIVILEGES;
EOF
else
    echo "[INFO] MariaDB is already configured."
fi

exec mysqld --user=mysql

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
fi

# ###### Tests dans la database. #######

# # -- Connexion en tant que root
# mysql -u root

# # -- Sécurisation de l'utilisateur root
# ALTER USER 'root'@'localhost' IDENTIFIED BY 'votre_mot_de_passe_root';

# # -- Création de la base de données WordPress
# CREATE DATABASE wordpress;

# # -- Création de l'utilisateur WordPress avec accès depuis n'importe où ('%')
# CREATE USER 'wp_user'@'%' IDENTIFIED BY 'votre_mot_de_passe_wp';

# # -- Attribution des permissions à l'utilisateur WordPress
# GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';

# # -- Application des changements
# FLUSH PRIVILEGES;

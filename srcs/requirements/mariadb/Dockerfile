#On se base sur l'image docker debian.
FROM    debian:bullseye

#On definit le WORKDIR qui sera par default lors du lancement du container.
WORKDIR /

RUN     apt update -y
RUN     apt upgrade -y

RUN     apt install mariadb-server -y
RUN     rm -rf /var/lib/mysql/*

#Copie le fichier de config de MariaDB ainsi que le script pour initialiser la database.
COPY    conf/my.cnf /etc/mysql/my.cnf
COPY    conf/config.sh /tmp/config.sh

RUN     chmod +x /tmp/config.sh

CMD ["sh", "/tmp/config.sh"]

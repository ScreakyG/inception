#On se base sur l'image docker debian.
FROM debian:bullseye

#On definit le WORKDIR qui sera par default lors du lancement du container.
WORKDIR /

#On update les packages et on install nginx.
RUN apt update -y
RUN apt install -y nginx
#RUN apt install OpenSSL -y #Semble optionnel car il est deja possible d'utiliser la CLI openssl , peut etre inclu dans l'installation du package nginx ?

#Enlever pour le rendu final , sert principalement pour debugger.
RUN apt install -y nano
RUN apt install -y curl

#Creation du dossier pour la certification ssl , generation du certificat et de la cle du certificat
RUN mkdir /etc/nginx/ssl-certs
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl-certs/nginx-selfsigned.key -out /etc/nginx/ssl-certs/nginx-selfsigned.crt -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=fgonzale.42.fr"

#On copie la configuration de nginx.
COPY conf/nginx.conf /etc/nginx/

# On veut s'assurer que nginx aura les droits pour aller chercher dans les dossiers les pages.
# RUN chmod 755 /var/www/html
# RUN chown -R www-data:www-data /var/www/html #Defini l'utilisateur de nginx comme proprietaire du dossier.

#NGINX utilise le port 80 alors on l'expose, sert principalement a informe l'utilisateur du dockerfile que notre app dans le container utilise le port 80.
# EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

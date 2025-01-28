RED = \033[31m
GRE = \033[32m
GRA = \033[37m
BLU = \033[34m
EOC = \033[0m

LOGIN = fgonzale
DATA_PATH = /home/$(LOGIN)/data
ENV = LOGIN=$(LOGIN) DATA_PATH=$(DATA_PATH)



YML_PATH = ./srcs/docker-compose.yml


# NGINX_DOCKERFILE_PATH = ./srcs/requirements/nginx
NGINX_IMAGE_NAME = nginx:42
MARIADB_IMAGE_NAME = mariadb:42
WORDPRESS_IMAGE_NAME = wordpress:42

# all: build_images up

all: up

up: configure_login
	@echo "$(GRE)[Starting services.. 🟢]$(EOC)"
	$(ENV) docker-compose -f $(YML_PATH) up --build

down:
	@echo "$(GRE)[Stopping services.. 🔴]$(EOC)"
	$(ENV) docker-compose -f $(YML_PATH) down

configure_login:
	sudo mkdir -p $(DATA_PATH)/wordpress-data
	sudo mkdir -p $(DATA_PATH)/mariadb-data

fclean: down
	@echo "$(RED)[Cleaning .. 🗑️ ]$(EOC)"

	docker rmi $(NGINX_IMAGE_NAME)
	docker rmi $(MARIADB_IMAGE_NAME)
	docker rmi $(WORDPRESS_IMAGE_NAME)

	docker image prune -f
	docker network prune -f
	docker volume prune -f

	docker volume rm srcs_wordpress
	# docker volume rm srcs_mariadb
	sudo rm -rf $(DATA_PATH)

re: fclean all

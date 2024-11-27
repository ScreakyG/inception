RED = \033[31m
GRE = \033[32m
GRA = \033[37m
BLU = \033[34m
EOC = \033[0m


YML_PATH = ./srcs/docker-compose.yml


# NGINX_DOCKERFILE_PATH = ./srcs/requirements/nginx
NGINX_IMAGE_NAME = nginx:42

# all: build_images up

all: up

up:
	@echo "$(GRE)[Starting services.. 🟢]$(EOC)"
	docker-compose -f $(YML_PATH) up

down:
	@echo "$(GRE)[Stopping services.. 🔴]$(EOC)"
	docker-compose -f $(YML_PATH) down

# build_images:
# 	@echo "$(GRE)[Building NGINX Image.. 📝]$(EOC)"
# 	docker build -t $(NGINX_IMAGE_NAME) $(NGINX_DOCKERFILE_PATH)

fclean:
	@echo "$(RED)[Cleaning up.. 🗑️ ]$(EOC)"
	@echo "$(GRE)[Stopping services.. 🔴]$(EOC)"

	docker-compose -f $(YML_PATH) down
	docker rmi $(NGINX_IMAGE_NAME)
	
	docker image prune -f
	docker network prune -f

re: fclean all

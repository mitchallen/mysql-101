# Makefile for managing MySQL Docker container

# Variables
CONTAINER_NAME=mysql-container
MYSQL_IMAGE=mysql:latest
VOLUME_NAME=mysql-data
SQL_FILE_PATH=./mysql_script.sql  # Change this to the path of your SQL script

# Default target: help
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make pull          - Pull the MySQL Docker image"
	@echo "  make run           - Run the MySQL Docker container"
	@echo "  make connect       - Connect to the MySQL Docker container"
	@echo "  make stop          - Stop the MySQL Docker container"
	@echo "  make remove        - Remove the MySQL Docker container"
	@echo "  make volume-create - Create a named volume for MySQL"
	@echo "  make volume-remove - Remove the named volume for MySQL"
	@echo "  make run-script    - Run an SQL script file from your local machine"

# Function to prompt for password
define prompt_password
	read -s password; \
	echo $$password
endef

# Pull the MySQL image
.PHONY: pull
pull:
	docker pull $(MYSQL_IMAGE)

# Run the MySQL container
.PHONY: run
run: pull
	$(eval MYSQL_ROOT_PASSWORD=$(shell $(prompt_password)))
	docker run --name $(CONTAINER_NAME) -v $(VOLUME_NAME):/var/lib/mysql -e MYSQL_ROOT_PASSWORD=$(MYSQL_ROOT_PASSWORD)  -p 3306:3306 -d $(MYSQL_IMAGE)

# Connect to the MySQL container
.PHONY: connect
connect:
	$(eval MYSQL_ROOT_PASSWORD=$(shell $(prompt_password)))
	docker exec -it $(CONTAINER_NAME) mysql -uroot -p$(MYSQL_ROOT_PASSWORD)

# Stop the MySQL container
.PHONY: stop
stop:
	docker stop $(CONTAINER_NAME)

# Remove the MySQL container
.PHONY: remove
remove: stop
	docker rm $(CONTAINER_NAME)

# Create a named volume
.PHONY: volume-create
volume-create:
	docker volume create $(VOLUME_NAME)

# Remove the named volume
.PHONY: volume-remove
volume-remove:
	docker volume rm $(VOLUME_NAME)

# Run an SQL script file from your local machine
.PHONY: run-script
run-script:
	$(eval MYSQL_ROOT_PASSWORD=$(shell $(prompt_password)))
	docker cp $(SQL_FILE_PATH) $(CONTAINER_NAME):/tmp/script.sql
	docker exec -it $(CONTAINER_NAME) mysql -uroot -p$(MYSQL_ROOT_PASSWORD) < /tmp/script.sql
	docker exec -it $(CONTAINER_NAME) rm /tmp/script.sql

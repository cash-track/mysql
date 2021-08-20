include .env
export

# Local config
CONTAINER_NAME=cashtrack_mysql
DB_NAME=cashtrack
DB_USER=cashtrack
DB_PASS=secret
DB_PORT=33060

# Deploy config
REPO=cashtrack/mysql
IMAGE_RELEASE=$(REPO):$(RELEASE_VERSION)
IMAGE_DEV=$(REPO):dev
IMAGE_LATEST=$(REPO):latest

.PHONY: build tag push start stop network

build:
	docker build . -t $(IMAGE_DEV) --no-cache

tag:
	docker tag $(IMAGE_DEV) $(IMAGE_RELEASE)
	docker tag $(IMAGE_DEV) $(IMAGE_LATEST)

push:
	docker push $(IMAGE_RELEASE)
	docker push $(IMAGE_LATEST)

start:
	mkdir -p data
	docker run \
	  --rm \
      --name $(CONTAINER_NAME) \
      --net cash-track-local \
      -v "$(PWD)/data":/var/lib/mysql \
      -p $(DB_PORT):3306 \
      -e MYSQL_ROOT_PASSWORD=secret \
      -e MYSQL_DATABASE=$(DB_NAME) \
      -e MYSQL_USER=$(DB_USER) \
      -e MYSQL_PASSWORD=$(DB_PASS) \
      -d \
      $(IMAGE_DEV)

stop:
	docker stop $(CONTAINER_NAME)

network:
	docker network create --driver bridge cash-track-local || true

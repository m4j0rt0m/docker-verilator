IMG             ?= stable
DOCKER_NAME     := verilator
DOCKER_VERSION  := $(IMG)
DOCKER_HUB_USER := m4j0rt0m

DOCKER_IMAGE    := $(IMG)/Dockerfile

all: build login tag push

build: $(DOCKER_IMAGE)
	@set -e; \
	docker build -t $(DOCKER_NAME):$(DOCKER_VERSION) $(IMG)

login:
	@set -e; \
	docker login

tag: build
	@set -e; \
	docker tag $(DOCKER_NAME):$(DOCKER_VERSION) $(DOCKER_HUB_USER)/$(DOCKER_NAME):$(DOCKER_VERSION)

push: login tag
	@set -e; \
	docker push $(DOCKER_HUB_USER)/$(DOCKER_NAME):$(DOCKER_VERSION)

clean:
	@set -e; \
	containers=$(shell docker ps -a -q --filter ancestor=$(DOCKER_NAME):$(DOCKER_VERSION)); \
	if [ -n "$$containers" ]; then \
		docker rm -f $$containers; \
	fi; \
	image_exists=$$(docker images -q $(DOCKER_NAME):$(DOCKER_VERSION)); \
	if [ -n "$$image_exists" ]; then \
		docker rmi -f $(DOCKER_NAME):$(DOCKER_VERSION); \
	fi; \
	image_exists=$$(docker images -q $(DOCKER_HUB_USER)/$(DOCKER_NAME):$(DOCKER_VERSION)); \
	if [ -n "$$image_exists" ]; then \
		docker rmi -f $(DOCKER_HUB_USER)/$(DOCKER_NAME):$(DOCKER_VERSION); \
	fi

.PHONY: all build login tag push clean

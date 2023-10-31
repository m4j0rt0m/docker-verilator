DOCKER_DIR      := base
DOCKER_NAME     := verilator
DOCKER_VERSION  := stable
DOCKER_HUB_USER := m4j0rt0m

DOCKER_IMAGE    := $(DOCKER_DIR)/Dockerfile

all: build login tag push

build: $(DOCKER_IMAGE)
	docker build -t $(DOCKER_NAME):$(DOCKER_VERSION) $(DOCKER_DIR)

login:
	docker login

tag:
	docker tag $(DOCKER_NAME):$(DOCKER_VERSION) $(DOCKER_HUB_USER)/$(DOCKER_NAME):$(DOCKER_VERSION)

push:
	docker push $(DOCKER_HUB_USER)/$(DOCKER_NAME):$(DOCKER_VERSION)

clean:
	docker rmi $(DOCKER_NAME):$(DOCKER_VERSION) $(DOCKER_HUB_USER)/$(DOCKER_NAME):$(DOCKER_VERSION)

.PHONY: build

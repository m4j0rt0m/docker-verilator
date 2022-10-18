DOCKER_DIR      := base
DOCKER_NAME     := verilator
DOCKER_VERSION  := stable

build:
	docker build -t $(DOCKER_NAME):$(DOCKER_VERSION) $(DOCKER_DIR)

.PHONY: build

DOCKER_REPO := wh1t3f0x
APP_NAME := spindra
VERSION := latest

.PHONY: help

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build the container
	@docker build -t $(DOCKER_REPO)/$(APP_NAME) .

build-nc: ## Build the container without cache
	@docker build --no-cache -t $(DOCKER_REPO)/$(APP_NAME) .

publish: # Publish the latest version
	@docker push $(DOCKER_REPO)/$(APP_NAME):$(VERSION)

release: build-nc publish ## Make a release

include .makefile/helpers.mk

all: shell
.PHONY: build shell install-deps format format-check check halt help

build:																		## Build container
	docker-compose build

shell: container-mars-rover-kata											## Enter into container
	docker-compose exec mars-rover-kata bash

install-deps: container-mars-rover-kata										## Install dependencies
	docker-compose exec mars-rover-kata mix deps.get

format: container-mars-rover-kata											## Execute code formatting
	docker-compose exec -T mars-rover-kata mix format.all

format-check: container-mars-rover-kata										## Execute code format verification
	docker-compose exec -T mars-rover-kata mix format.check

check: container-mars-rover-kata											## Execute static code analysis
	docker-compose exec -T mars-rover-kata mix credo --strict

halt:																		## Shoutdown
	docker-compose down

help:
	@perl -e '$(HELP_FUNC)' $(MAKEFILE_LIST)

container-%:
	@docker ps -q --no-trunc --filter status=running | grep $$(docker-compose ps -q $*) >/dev/null 2>&1 || docker-compose up -d $*

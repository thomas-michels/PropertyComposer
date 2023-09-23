include ./.env

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)


TARGET_MAX_CHAR_NUM=20


## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Clean All unsed images
clean-images:
	docker image prune -a

## Pull and run address service
pull-and-run-address-service:
	docker pull ${LATEST_ADDRESS_SERVICE}
	docker run -d --name address-service --env-file ./envs/address-service.env --network=${NETWORK} --restart always -p 8000:8000 ${LATEST_ADDRESS_SERVICE}

## Pull and run property service
pull-and-run-property-service:
	docker pull ${LATEST_PROPERTY_SERVICE}
	docker run -d --name property-service --env-file ./envs/property-service.env --network=${NETWORK} --restart always ${LATEST_PROPERTY_SERVICE}

## Pull and run property crawler
pull-and-run-property-crawler:
	docker pull ${LATEST_PROPERTY_CRAWLER}
	docker run -d --name property-crawler --env-file ./envs/property-crawler.env --network=${NETWORK} --restart always ${LATEST_PROPERTY_CRAWLER}

## Pull and run property maestro
pull-and-run-property-maestro:
	docker pull ${LATEST_PROPERTY_MAESTRO}
	docker run -d --name property-maestro --env-file ./envs/property-maestro.env --network=${NETWORK} --restart always ${LATEST_PROPERTY_MAESTRO}

## Pull and run property API
pull-and-run-property-api:
	docker pull ${LATEST_PROPERTY_API}
	docker run -d --name property-api --env-file ./envs/property-api.env --network=${NETWORK} --restart always ${LATEST_PROPERTY_API}

## Remove address service
remove-address-service:
	docker stop address-service
	docker rm address-service

## Remove property service
remove-property-service:
	docker stop property-service
	docker rm property-service

## Remove property crawler
remove-property-crawler:
	docker stop property-crawler
	docker rm property-crawler

## Remove property maestro
remove-property-maestro:
	docker stop property-maestro
	docker rm property-maestro

## Remove property api
remove-property-api:
	docker stop property-api
	docker rm property-api

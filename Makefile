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

## Pull and run grey wolf service
pull-and-run-grey-wolf-service:
	docker pull ${LATEST_GREY_WOLF_SERVICE}
	docker run -d --name grey-wolf-service --env-file ./envs/grey-wolf-service.env --network=${NETWORK} --restart always --cpus 1 --memory 2g ${LATEST_GREY_WOLF_SERVICE}

## Pull and run grey wolf consumer1
pull-and-run-grey-wolf-consumer1:
	docker pull ${LATEST_GREY_WOLF_SERVICE_CONSUMER}
	docker run -d --name grey-wolf-service-consumer-1 --env-file ./envs/grey-wolf-service.env --network=${NETWORK} --restart always --cpus 1.5 --memory 5g ${LATEST_GREY_WOLF_SERVICE_CONSUMER}

## Pull and run grey wolf consumer2
pull-and-run-grey-wolf-consumer2:
	docker pull ${LATEST_GREY_WOLF_SERVICE_CONSUMER}
	docker run -d --name grey-wolf-service-consumer-2 --env-file ./envs/grey-wolf-service.env --network=${NETWORK} -p 8001:8000 --restart always --cpus 1.5 --memory 5g ${LATEST_GREY_WOLF_SERVICE_CONSUMER}

## Pull and run real estate previsor
pull-and-run-real-estate-previsor:
	docker pull ${LATEST_REAL_ESTATE_PREVISOR}
	docker run -d --name real-estate-previsor --env-file ./envs/real-estate-previsor.env --network=${NETWORK} -p 80:8507 --restart always ${LATEST_REAL_ESTATE_PREVISOR}

## Remove address service
remove-address-service:
	docker stop address-service
	docker rm address-service

## Remove address service2
remove-address-service2:
	docker stop address-service2
	docker rm address-service2

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

## Remove grey wolf service
remove-grey-wolf-service:
	docker stop grey-wolf-service
	docker rm grey-wolf-service

## Remove grey wolf service consumer 1
remove-grey-wolf-service-consumer-1:
	docker stop grey-wolf-service-consumer-1
	docker rm grey-wolf-service-consumer-1

## Remove grey wolf service consumer 2
remove-grey-wolf-service-consumer-2:
	docker stop grey-wolf-service-consumer-2
	docker rm grey-wolf-service-consumer-2

## Remove real estate previsor
remove-real-estate-previsor:
	docker stop real-estate-previsor
	docker rm real-estate-previsor

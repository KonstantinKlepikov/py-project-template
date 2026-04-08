# target: all - Default target. Does nothing.
all:
	@echo "Hello, this is make for tiny-rewards-tg"
	@echo "Try 'make help' and search available options"

# target: help - List of options
help:
	@egrep "^# target:" [Mm]akefile

# target: serve dev - run docker-compose
serve:
	@sh ./docker-compose/up-dev.sh

# target: down - stop and down docker stack
down:
	@docker compose -f ./docker-compose/docker-stack.yml down

# target: down-rm - stop and down docker stack, then remove all images
down-rm:
	@docker compose -f ./docker-compose/docker-stack.yml down --rmi al

# target: check - run tests, mypy and flake8
check:
	@echo "py-project-template-dev:"
	@docker compose -f ./docker-compose/docker-stack.yml exec py-project-template-dev sh -c "cd .. && sh scripts/check.sh"

# target: config - show stack info
config:
	@echo "Services:"
	@docker compose -f ./docker-compose/docker-stack.yml config --services
	@echo "Volumes:"
	@docker compose -f ./docker-compose/docker-stack.yml config --volumes

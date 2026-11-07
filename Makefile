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

# target: config - show docker stack info
config:
	@echo "Services:"
	@docker compose -f ./docker-compose/docker-stack.yml config --services
	@echo "Volumes:"
	@docker compose -f ./docker-compose/docker-stack.yml config --volumes

# target: env - create docker-compose/.env file; optionally set python version and creates python environment
# Usage: make env [python=3.12]
env:
	@sh scripts/env.sh "$(python)"

# target: rename - replace 'py-project-template' with --to value in key project files
# Usage: make rename to=my-new-name
rename:
ifndef to
	$(error Argument <to> is required. Usage: make rename to=my-new-name)
endif
	@sed -i 's/py-project-template/$(to)/g' \
		AGENTS.md \
		Makefile \
		pyproject.toml \
		README.md \
		docker-compose/docker-compose.dev.yml
	@sed -i '/^# target: rename/,$$d' Makefile

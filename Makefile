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

# target: create - create a python file with optional prompt header
# Usage: make create path=src/module.py [pr=prompt1[,prompt2,...]]
create:
ifndef path
	$(error Argument <path> is required. Usage: make create path=src/module.py)
endif
	@sh scripts/create.sh "$(path)" "$(pr)"

# target: clean - remove leading triple-quoted comment block from a python file
# Usage: make clean path=src/module.py
clean:
ifndef path
	$(error Argument <path> is required. Usage: make clean path=src/module.py)
endif
	@sh scripts/clean.sh "$(path)"

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

# py-project-template how to use

NOTE: **REMOVE THIS INSTRUCTION AFTER DEPLOY**

## Stack

- python 3.12+ (default 3.14)
- poetry
- pytest
- pytest-asyncio
- loguru
- pep8
- mypy
- makefile
- github actions

## Build local

Change python version before instalation (install and use `pyenv` for different python versions).

```txt
# .python-version

3.14.0
```

Change version of python docker image in `docker-compose/Dockerfile.base`.

Define placement of `.venv` folder local

```toml
# poetry.toml

virtualenvs.create = true
virtualenvs.prefer-active-python = true
# ... some other variables
```

- `poetry config virtualenvs.in-project true` if you don't use poetry.toml
- `poetry install --with dev --no-root` install poetry dependencies

## Use local

Create `.env` file in `docker-compose` folder

- `make rename to=<new-name>` rename project after clone template. This command delete itself after renaming
- `make serve` up and serve docker stack
- `make down` down docker stack
- `make check` tests, lint and mypy all
- `make config` show docker stack info
- `make create path=src/module.py [pr=prompt_name]` - create a python file with optional prompt header
- `make clean path=src/module.py` - Remove leading triple-quoted comment block from python file

Use `research` folder for experiments. Use `prompts` folder for llm system prompts.

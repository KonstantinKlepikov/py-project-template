# py-project-template

## Build local

Change python version before instalation (install and use `pyenv` for different python versions)

```txt
# .python-version

3.14.0
```

Change version of python docker image in `docker-compose/Dockerfile.base`

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

- `make serve` up and serve docker stack
- `make down` down docker stack
- `make check` tests, lint and mypy all
- look for other command in `Makefile`

Use `research` folder for experiments.

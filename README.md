# py-project-template

## Build local

Change python version before instalation (install and use `pyenv` for different python versions)

```txt
# .python-version

3.12.5
```

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

- `make serve` not implemented
- `make down` not implemented
- `make clean` not implemented
- `make check` tests, lint and mypy all

Use `docker-compose` folder for difinition of docker images, related to development.

Use `research` folder for experiments.

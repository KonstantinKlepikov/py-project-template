# py-project-template

Use this repo as template for python projects

- `make serve` not implemented
- `make down` not implemented
- `make clean` not implemented
- `make check` tests, lint and mypy all
- `poetry config virtualenvs.in-project true` if you nto use poetry.toml
- `poetry install --with dev --no-root` install poetry dependencies

To change python version before instalation (use `pyenv`)

```txt
# .python-version

3.12.5
```

Define placement of `.venv` folder

```toml
# poetry.toml

virtualenvs.create = true
virtualenvs.prefer-active-python = true
# ... some other variables
```

Use `docker-compose` folder for difinition of docker images, related to development.

Use `research` folder for experiments.

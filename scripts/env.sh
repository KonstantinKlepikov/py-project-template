#!/bin/sh
# Usage: sh scripts/env.sh [python_version]
set -e

PYTHON_VERSION="$1"

if [ ! -f docker-compose/.env ]; then
    touch docker-compose/.env
    echo "Created: docker-compose/.env"
else
    echo "Skipped: docker-compose/.env already exists"
fi

if [ ! -f .vscode/settings.json ]; then
    mkdir -p .vscode
    PROJECT_PATH="$(pwd)"
    printf '{\n    "python.defaultInterpreterPath": "%s/.venv/bin/python3",\n    "python.analysis.extraPaths": [\n        "./src/",\n        "./tests/"\n    ],\n    "python.analysis.diagnosticSeverityOverrides": {\n        "reportMissingImports": "none"\n    },\n    "editor.accessibilitySupport": "off",\n    "editor.formatOnSave": true,\n    "flake8.importStrategy": "fromEnvironment",\n    "mypy-type-checker.importStrategy": "fromEnvironment",\n    "python.testing.unittestEnabled": false,\n    "python.testing.pytestEnabled": true\n}\n' "$PROJECT_PATH" > .vscode/settings.json
    echo "Created: .vscode/settings.json"
else
    echo "Skipped: .vscode/settings.json already exists"
fi

if [ -n "$PYTHON_VERSION" ]; then
    MAJOR=$(echo "$PYTHON_VERSION" | cut -d. -f1)
    MINOR=$(echo "$PYTHON_VERSION" | cut -d. -f2)
    if [ "$MAJOR" -ne 3 ] || [ "$MINOR" -lt 12 ]; then
        echo "Error: python version must be >=3.12,<4.0 (got $PYTHON_VERSION)"
        exit 1
    fi
    sed -i "s|^FROM python:[^-]*|FROM python:$PYTHON_VERSION|" docker-compose/Dockerfile.base
    echo "$PYTHON_VERSION.0" > .python-version
    echo "Updated Dockerfile.base and .python-version to Python $PYTHON_VERSION"
fi

poetry install --with dev --no-root

echo ""
echo "To activate the virtual environment, run:"
echo "  source $(pwd)/.venv/bin/activate"

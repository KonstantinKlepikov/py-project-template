#!/bin/sh
# Usage: sh scripts/clean.sh <path>
set -e

FILE_PATH="$1"

if [ -z "$FILE_PATH" ]; then
    echo "Error: path argument is required. Usage: sh scripts/clean.sh src/module.py"
    exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: file '$FILE_PATH' does not exist"
    exit 1
fi

sed -i '/^"""/,/^"""/d' "$FILE_PATH"
sed -i '/./,$!d' "$FILE_PATH"
echo "Cleaned: $FILE_PATH"

#!/bin/sh
# Usage: sh scripts/create.sh <path> [prompt1,prompt2,...]
set -e

FILE_PATH="$1"
PROMPTS="$2"

if [ -z "$FILE_PATH" ]; then
    echo "Error: path argument is required. Usage: sh scripts/create.sh src/module.py [prompt1,prompt2,...]"
    exit 1
fi

PARENT="$(dirname "$FILE_PATH")"
if [ ! -d "$PARENT" ]; then
    echo "Error: directory '$PARENT' does not exist"
    exit 1
fi

PROMPT_BLOCK=""
if [ -n "$PROMPTS" ]; then
    TMPBLOCK=$(mktemp)
    for name in $(echo "$PROMPTS" | tr ',' ' '); do
        PROMPT_FILE=$(find prompts -maxdepth 1 \( -name "$name.*" -o -name "$name" \) 2>/dev/null | head -1)
        if [ -z "$PROMPT_FILE" ]; then
            echo "Error: prompt file '$name' not found in prompts/"
            rm -f "$TMPBLOCK"
            exit 1
        fi
        printf '"""\n' >> "$TMPBLOCK"
        cat "$PROMPT_FILE" >> "$TMPBLOCK"
        printf '"""\n' >> "$TMPBLOCK"
    done
    PROMPT_BLOCK="$TMPBLOCK"
fi

if [ -e "$FILE_PATH" ]; then
    if [ -z "$PROMPTS" ]; then
        echo "Error: file '$FILE_PATH' already exists"
        exit 1
    fi
    TMPFILE=$(mktemp)
    awk -v pfile="$PROMPT_BLOCK" 'BEGIN{b=0;d=0} !d&&/^"""$/{if(b){b=0;h=h $0"\n";next}else{b=1;h=h $0"\n";next}} !d&&b{h=h $0"\n";next} !d{d=1;printf "%s",h;while((getline l<pfile)>0)print l;print;next} {print} END{if(!d){printf "%s",h;while((getline l<pfile)>0)print l}}' "$FILE_PATH" > "$TMPFILE" && mv "$TMPFILE" "$FILE_PATH"
    rm -f "$PROMPT_BLOCK"
    echo "Updated: $FILE_PATH"
else
    if [ -n "$PROMPTS" ]; then
        cat "$PROMPT_BLOCK" > "$FILE_PATH"
        rm -f "$PROMPT_BLOCK"
    else
        touch "$FILE_PATH"
    fi
    echo "Created: $FILE_PATH"
fi

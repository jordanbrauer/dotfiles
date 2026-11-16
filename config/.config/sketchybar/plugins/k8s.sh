#!/bin/bash

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

CONTEXT=$(kubectl config current-context 2>/dev/null)

if [ -z "$CONTEXT" ]; then
    sketchybar --set "$NAME" label="none"
    exit 0
fi

LABEL=$(echo "$CONTEXT" | sed 's|.*/||')

sketchybar --set "$NAME" label="$LABEL"

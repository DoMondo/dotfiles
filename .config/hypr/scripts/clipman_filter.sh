#!/bin/bash
# Script to filter clipboard content before passing to clipman
# Goal: Ignore images to avoid bloating history, but allow text and file paths (wcopy)

# Check available types in current clipboard selection
TYPES=$(wl-paste --list-types)

# If it contains an image, ignore it completely (exit)
if echo "$TYPES" | grep -q "^image/"; then
    exit 0
fi

# Otherwise, store it in clipman as plain text
# We explicitly request text/plain so clipman gets the path string for files,
# but we don't block the original selection source from offering other types.
wl-paste --type text/plain --no-newline | clipman store --max-items=255

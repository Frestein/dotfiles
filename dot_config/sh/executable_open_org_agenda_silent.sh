#!/usr/bin/env sh

# Wait for Emacs daemon to become ready
while ! emacsclient -e t >/dev/null 2>&1; do
    sleep 1
done

# Open the agenda view in a new frame
emacsclient -nc -F "((title . \"org-agenda\") (name . \"emacs-agenda\"))" \
    -e "(fr/open-agenda-with-redo \"d\")"

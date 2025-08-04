#!/usr/bin/env dash

PROMPT="$1"

shift

rofimoji --prompt "$PROMPT" --files "$@" --action clipboard --clipboarder wl-copy

---
name: bump-pinned-versions
description: 'Use when bumping pinned chezmoi external versions with scripts/bump-pinned-versions.py or processing nvchecker results.'
---

# Bump pinned versions

`scripts/bump-pinned-versions.py` compares nvchecker results with
`home/.chezmoidata/versions.toml`, edits the pins, commits and runs `nvtake`.
Human-facing documentation is `docs/bump-pinned-versions.org` in the chezmoi
source repository.

## Rules

1. Never run the script without `--dry-run`: without it the script edits files,
   commits and takes versions. Leave the real run to the user.
2. Never read `~/.config/nvchecker/keyfile.toml` (a gopass-backed token), and
   never paste its value into chat or logs.
3. The user runs `chezmoi apply` after a bump to refresh the externals.

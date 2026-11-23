Always load the `chezmoi` skill before reading or editing any dotfile in this repository.
Never run `chezmoi apply`, `chezmoi status`, `chezmoi diff`, `chezmoi add --encrypt`, or `chezmoi re-add --re-encrypt`, and never read target files that the skill marks as sensitive.
Always load the `commit` skill before drafting a commit message.
Never read, edit, glob or grep files outside the repo root and the allowlist in `~/.config/opencode/opencode.jsonc`. Never read target files marked sensitive by the `chezmoi` skill (encrypted-source results, gopass-rendered configs, credentials, browser profiles, token stores, anything excluded by `.chezmoiignore`) — read the source copy instead.

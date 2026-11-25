Always load the `chezmoi` skill before reading or editing any dotfile in this repository.
Never run `chezmoi apply`, `chezmoi status`, `chezmoi diff`, `chezmoi init`, `chezmoi update`, `chezmoi add --encrypt`, or `chezmoi re-add --re-encrypt`, and never read target files that the skill marks as sensitive.
Always load the `commit` skill before drafting a commit message.
Never read, edit, glob or grep files outside the repo root and the allowlist in `~/.config/opencode/opencode.jsonc`. Never read target files marked sensitive by the `chezmoi` skill (encrypted-source results, gopass-rendered configs, credentials, browser profiles, token stores, anything excluded by `.chezmoiignore`) — read the source copy instead.

## Locally protected state files

The following sources are updated by `chezmoi-watcher.service` and marked
locally with `git update-index --skip-worktree`, so they do not appear in
`git status` and are not picked up by `git add -A`:

- `home/dot_config/doom/encrypted_bookmarks.eld.asc`
- `home/dot_config/private_YouTube Music/encrypted_config.json.asc`
- `home/dot_config/private_goofcord/GoofCord/encrypted_settings.json.asc`
- `home/dot_config/private_qalculate/qalc.cfg`

Never stage or commit these files unless the user explicitly asks to record
significant changes. Before committing, check the protected files with
`git ls-files -v | grep '^S'`.

To commit a change:

```sh
git update-index --no-skip-worktree <path>
git add <path>
git commit -m '...'
git update-index --skip-worktree <path>
```

The flags live only in the local `.git/index`. After cloning or recreating
`.git`, re-apply them:

```sh
git update-index --skip-worktree -- \
  home/dot_config/doom/encrypted_bookmarks.eld.asc \
  "home/dot_config/private_YouTube Music/encrypted_config.json.asc" \
  home/dot_config/private_goofcord/GoofCord/encrypted_settings.json.asc \
  home/dot_config/private_qalculate/qalc.cfg
```

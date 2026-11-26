Chezmoi conventions are documented in
`home/dot_config/opencode/skills/chezmoi/references/chezmoi-conventions.md`;
read them before working with dotfiles. Commit conventions live in
`docs/commit-conventions.org`; read them before drafting a commit message.

Never run `chezmoi apply`, `chezmoi status`, `chezmoi diff`, `chezmoi init`,
`chezmoi update`, `chezmoi add --encrypt`, or `chezmoi re-add` (including
`--re-encrypt`). The latter copies deployed files back into the source state
and can involve encrypted files.
Never read, edit, glob or grep files outside the repository root. Never read
deployed files marked as sensitive by the chezmoi conventions (encrypted-source
results, gopass-rendered configs, credentials, browser profiles, token stores,
anything excluded by `.chezmoiignore`) — read the source copy instead.

## Chezmoi source state

All changes are made in the source state only, never in deployed targets
under `$HOME`. Applying the source state is the user's responsibility.
Never edit a target directly.

## Chezmoi data and templates

- Contents of `.chezmoidata/*.yaml` and `.toml` are merged into the root
  template data, not nested under a key derived from the filename. Wrap
  values in a top-level key (for example `fzf:`) to namespace them.
- Templates must be human-readable: use block form with trim markers
  (`{{- range ... }}` / `{{- end }}`), not an action and a value on one line.

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

## Deprecated package data

`.chezmoidata/packages.yaml`, the Arch install script that consumes it
(`.chezmoiscripts/linux/arch/run_onchange_01-install-arch-packages.sh.tmpl`)
and the `get-packages-list` helper are a deprecated proof of concept. They are
not the source of truth for installed packages and are not used in practice.
Do not rely on them or extend them; the package workflow needs to be rewritten.

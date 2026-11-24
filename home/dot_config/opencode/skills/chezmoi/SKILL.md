---
name: chezmoi
description: Use when working with chezmoi-managed dotfiles in this repository — editing ~/.config files, adding or renaming dotfiles, changing templates, externals or scripts, or whenever the user mentions chezmoi or dotfiles. Never run chezmoi apply, status, diff, init, update, add --encrypt, or re-add --re-encrypt.
---

# Chezmoi source-state workflow

## Iron rules

1. The chezmoi source tree is the single source of truth. Edit source files; never edit deployed targets.
2. Never run `chezmoi apply`, `chezmoi status`, `chezmoi diff`, `chezmoi init`, `chezmoi update`, `chezmoi add --encrypt`, or `chezmoi re-add --re-encrypt`. These commands render, decrypt, or re-encrypt secrets through GPG, re-render the config, or apply the source state; a non-interactive agent cannot answer pinentry, and secret values could leak into the conversation. The user performs these operations personally.
3. Never read target files containing secrets or local state:
   - decrypted results of `encrypted_*` sources (`~/.config/qutebrowser/quickmarks`, `~/.config/qutebrowser/web_exclude.txt`, `~/.config/YouTube Music/config.json`);
   - rendered results of templates calling `gopass` or other secret backends (`~/.config/authinfo`, `~/.config/nvchecker/keyfile.toml`, `~/.config/msmtp/config`);
   - credential material and runtime state (`~/.ssh/*`, `~/.gnupg/*`, browser profiles, token stores);
   - target paths that `.chezmoiignore` excludes because they are local, generated, or secret-bearing.
   Entries such as `**/node_modules/` or `**/__pycache__/` are build noise, not a secrecy signal.
4. Reading is allowed: any file in the source tree (including `private_*` and ordinary templates — `private_` only sets target permissions, it does not mean secret), the agent's own skills under `~/.config/opencode/skills/`, and plain target files that are exact copies of source. Prefer the source copy anyway.
5. Never edit `encrypted_*.asc` sources. Ask the user to run `chezmoi edit --apply <target>` when a secret must change.

## Path map

| Target | Source |
| --- | --- |
| `~/.config/nvim/init.lua` | `home/dot_config/nvim/init.lua` |
| `~/.config/fish/config.fish` | `home/dot_config/private_fish/config.fish` |
| `~/.local/bin/askpass` | `home/dot_local/bin/executable_askpass` |
| `~/.config/authinfo` | `home/dot_config/private_authinfo.tmpl` (target is sensitive) |

In source names, `dot_` becomes `.`, `private_` sets restrictive permissions, `executable_` sets the executable bit, and `.tmpl` is removed after rendering.

## Safe verification

- Read source files directly.
- Use `git status` and `git diff` in the repository root.
- `chezmoi source-path <target>` and `chezmoi managed` are safe: they read metadata, not secret values.
- Show the resulting `git diff` to the user and ask them to run `chezmoi apply`.

## Special files

- `.chezmoiignore` — target paths deliberately left unmanaged; also a hint about local state that should not be read.
- `.chezmoiexternals/*.toml.tmpl` — external dependencies; the user refreshes them with `CZ_EXT=1 chezmoi apply`.
- `.chezmoiscripts/` — `run_once_*` and `run_onchange_*` hooks.
- `.chezmoidata/packages.yaml` — package lists.
- `.chezmoi.toml.tmpl` — GPG encryption plus `delta` pager and `nvim` merge command: another reason never to run chezmoi commands without a TTY.

## Workflow

1. Locate the source file using the path map or `chezmoi source-path`.
2. Read it. In a `.tmpl`, preserve every `{{ ... }}` token; escape nested braces as `{{ "{{" }}`.
3. Edit the source only. Keep `dot_`, `private_`, `executable_` prefixes and the `.tmpl` suffix intact.
4. Show `git diff`, then ask the user to run `chezmoi apply`.
5. Before renaming files or changing attributes/templates, read `references/chezmoi-conventions.md`.

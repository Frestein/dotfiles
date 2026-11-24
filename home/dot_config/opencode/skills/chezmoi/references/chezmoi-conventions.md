# Chezmoi conventions in this repository

This is supporting material for the `chezmoi` skill. Read it before renaming files, changing attributes, or writing templates.

## Layout

- `.chezmoiroot` contains `home`, so the git repository root holds documentation and metadata while chezmoi manages only `home/`.
- In this project the working directory is the chezmoi source tree itself; all paths below are relative to it.

## Source-state attributes

| Source name | Target |
| --- | --- |
| `dot_gitconfig` | `~/.gitconfig` |
| `dot_config/nvim/` | `~/.config/nvim/` |
| `private_config.toml` | plain name, mode 0600/0700 on target |
| `executable_script.sh` | plain name, executable bit set |
| `symlink_config` | a symlink at the target |
| `create_` | creates the file only if it is missing |
| `modify_` | patches an existing file instead of replacing it |
| `encrypted_config.asc` | decrypted on apply; never read its target |
| `config.tmpl` | Go template, `.tmpl` removed in the target |
| `config.literal` | copied verbatim, no template processing |

`private_` is about filesystem permissions, not secrecy of the source file.

## Templates

- Chezmoi uses Go `text/template` with sprig functions.
- Common values: `.chezmoi.os`, `.chezmoi.hostname`, `.chezmoi.arch`, `.chezmoi.sourceDir`, `.email`, `.github_user`.
- Platform branches: `{{- if eq .chezmoi.os "linux" }} ... {{ end }}`.
- To emit literal braces for a target format that also uses `{{ }}`: `{{ "{{" }}value{{ "}}" }}`.
- A source template may call secret backends (`gopass`, `secret`). Its rendered target must never be read.

## Externals

- `.chezmoiexternals/*.toml.tmpl` defines git repositories and archives pulled into the target.
- The user refreshes them with `CZ_EXT=1 chezmoi apply`; do not run that yourself.

## Scripts

- `.chezmoiscripts/` files are named `run_[once_|onchange_][before_|after_]<order>-<name>.<ext>[.tmpl]`.
- `run_once_` runs one time; `run_onchange_` re-runs when the script content changes.

## Ignore rules

- `.chezmoiignore` patterns match target paths relative to `$HOME`; lines starting with `#` are comments.
- Ignored paths are kept out of source state: generated state, local-only files, and build noise such as `**/node_modules/` and `**/__pycache__/`.
- Treat an ignore entry as a warning about target content only when it exists to keep local or sensitive state out of the repository.

## Gotchas

- `[diff] pager = "delta"` and `[merge] command = "nvim"` in `.chezmoi.toml.tmpl` can hang without a TTY — one more reason not to run chezmoi diff/status/apply.
- The target of `encrypted_quickmarks.asc` is `~/.config/qutebrowser/quickmarks`, not a file named `encrypted_*`.
- `chezmoi source-path` and `chezmoi managed` are metadata-only and safe; commands that render templates are not.

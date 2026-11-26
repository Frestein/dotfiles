---
name: chezmoi-watcher
description: 'Use when working on chezmoi-watcher.service, its targets/ignore files, or diagnosing why a watched file was or was not re-added.'
---

# Chezmoi watcher

The service watches the paths in `~/.config/chezmoi-watcher/targets` and syncs
their chezmoi sources. Human-facing documentation is `docs/chezmoi-watcher.org`
in the chezmoi source repository.

## Rules

1. Files: `home/dot_local/bin/executable_chezmoi-watcher`,
   `home/dot_config/chezmoi-watcher/targets`,
   `home/dot_config/chezmoi-watcher/ignore`,
   `home/dot_config/chezmoi-watcher/quiet` and
   `home/dot_config/systemd/user/chezmoi-watcher.service`. After changing them,
   ask the user to restart `chezmoi-watcher.service`.
2. A trailing `/` in `targets` or `ignore` is the explicit directory marker.
   Never classify a directory by whether it currently exists.
3. `Skipping …: target already matches source state.` is a successful no-op
   for an identical-content rewrite, not a failure.
4. Read the unit log with `journalctl --user-unit=chezmoi-watcher.service -f`;
   see the `journal` skill for project-specific log details.
5. Do not stage or commit the protected state files listed in `AGENTS.md`;
   the watcher updates them locally.

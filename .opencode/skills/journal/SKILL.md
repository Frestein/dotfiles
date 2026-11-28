---
name: journal
description: 'Use when reading system logs in this dotfiles project, especially user units; never use `journalctl --user -u`.'
---

# Journalctl in this project

For generic flag semantics use the global `journalctl` skill. Project-specific
details:

- The user journal is not maintained here (`/run/user/1000/systemd/journal` is
  absent), so `journalctl --user` reports no journal files. Never combine
  `--user` with `-u`.
- User-unit entries live in the system journal. Filter them with
  `journalctl --user-unit=<name>.service`, which also matches the `USER_UNIT=`
  field used here; `-u` filters `_UNIT` and matches system units only.
- Example: `journalctl --user-unit=gpg-load-passphrase.service --no-pager -n 20`

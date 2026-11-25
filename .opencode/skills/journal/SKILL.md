---
name: journal
description: 'Use when reading system logs in this dotfiles project.'
---

# Journalctl in this project

For generic flag semantics use the global `journalctl` skill. Project-specific
details:

- The user journal is not maintained here (`/run/user/1000/systemd/journal` is
  absent), so `journalctl --user` reports no journal files.
- User-unit entries go to the system journal tagged `_SYSTEMD_USER_UNIT`.

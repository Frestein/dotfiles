---
name: journalctl
description: 'Use when reading systemd logs with journalctl.'
---

# Reading systemd logs

## Selecting units

- `journalctl --user-unit=<name>.service -f` filters by
  `_SYSTEMD_USER_UNIT=<name>.service`. Use this for **user** systemd units.
- `journalctl -u <name>.service` filters by `_UNIT`, which is set by **system**
  units. It does not match user units.
- `journalctl --user` selects the user journal instead of the system journal.
  It is a source selection, not a unit filter; combine it with care.
- `systemctl --user status <name>` queries `_SYSTEMD_USER_UNIT`, so it shows
  the same lines as `journalctl --user-unit=<name>.service`.

## Examples

```sh
journalctl --user-unit=<name>.service -f
journalctl -u <name>.service -f
systemctl --user status <name>.service
```

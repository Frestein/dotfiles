---
name: Commit message
description: 'Use when the user asks to write a commit message in Russian or English ("напиши коммит", "write a commit"), or when preparing changes for a commit in this repository. Conventional Commits (CC) rules live in docs/commit-conventions.org.'
---

# Commit message workflow

## Iron rule

Read `docs/commit-conventions.org` before drafting any commit message.
Resolve the root with `git rev-parse --show-toplevel`. It is the single
source of truth; never rely on memory or on another repository's
conventions.

## Draft

- Use one of the seven types listed in the document.
- A scope is optional. When present, use exactly one canonical scope from the
  `canonical-scopes` block; do not combine scopes or invent aliases. For a
  component without a canonical scope, ask the user whether to add one and
  propose concrete names; omit the scope only for changes that are not
  component-specific. When a component with a scope is removed, ask the user
  whether to remove that scope, then remove it from the conventions and
  regenerate `prek.toml`.
- The subsystem prefix is optional in the description, e.g.
  `feat(emacs): lua: add lsp config`. Omit it when the scope already names the
  subsystem.
- Wrap code identifiers in backticks in the subject. Example:

  ```text
  fix(systemd): check-disk-usage: use `OnCalendar` instead of `OnUnitActiveSec`
  ```

- Keep the subject within 50 characters when possible; 72 is the hard limit.
- Separate the subject from the body with a blank line; wrap the body at 72.
- The description is lowercase and has no trailing period.

## Workflow

1. Read the document.
2. Run `git status` and `git diff` to see the changes.
3. Draft the message and present it to the user.
4. Do not stage files or create the commit unless explicitly asked.

## History

Do not rewrite published history. Amending your own most recent,
unpublished commit is acceptable.

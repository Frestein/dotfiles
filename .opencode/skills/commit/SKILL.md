---
name: Commit message
description: 'Use when the user asks to write a commit message in Russian or English ("напиши коммит", "write a commit"), or when preparing changes for a commit in this repository. Conventional Commits (CC) rules live in docs/commit-conventions.org.'
---

# Commit message workflow

## Iron rule

Read `docs/commit-conventions.org` at the repository root before drafting
any commit message (from the chezmoi source directory the path is
`../docs/commit-conventions.org`). It is the single source of truth; never
rely on memory or on another repository's conventions.

## Draft

- Use one of the seven types listed in the document.
- Use exactly one canonical scope from the `canonical-scopes` block. Do not
  combine scopes and do not invent aliases. If no scope fits, propose adding
  one to the document first.
- Write the subsystem as a `section:` prefix in the description, e.g.
  `feat(emacs): lua: add lsp config`.
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

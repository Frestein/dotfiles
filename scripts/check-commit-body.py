#!/usr/bin/env python3
"""Check that commit message body lines stay within 72 characters."""

import re
import sys
from pathlib import Path

MAX_WIDTH = 72
URL_LINE = re.compile(r"^\s*https?://\S+\s*$")


def main() -> int:
    if len(sys.argv) != 2:
        print("usage: check-commit-body.py <commit-message-file>", file=sys.stderr)
        return 2

    lines = Path(sys.argv[1]).read_text(encoding="utf-8").splitlines()
    start = 1
    if start < len(lines) and not lines[start].strip():
        start += 1

    bad = []
    for number, line in enumerate(lines[start:], start=start + 1):
        stripped = line.strip()
        if not stripped or stripped.startswith("#") or URL_LINE.match(line):
            continue
        if len(line) > MAX_WIDTH:
            bad.append((number, len(line)))

    for number, length in bad:
        print(
            f"commit body line {number} is {length} chars (max {MAX_WIDTH})",
            file=sys.stderr,
        )
    return 1 if bad else 0


if __name__ == "__main__":
    raise SystemExit(main())

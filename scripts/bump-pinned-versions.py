#!/usr/bin/env python3
"""Bump pinned external versions from nvchecker results."""

import argparse
import json
import re
import subprocess
import sys
import tomllib
from pathlib import Path


def run(
    cmd: list[str], *, cwd: Path, capture: bool = False
) -> subprocess.CompletedProcess[str]:
    result = subprocess.run(
        cmd, check=False, cwd=cwd, text=True, capture_output=capture
    )
    if result.returncode != 0:
        print(
            f"error: {' '.join(cmd)} exited with {result.returncode}", file=sys.stderr
        )
        if capture and result.stderr:
            print(result.stderr.rstrip(), file=sys.stderr)
        sys.exit(result.returncode)
    return result


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="show pending version changes without editing, committing or taking versions",
    )
    args = parser.parse_args()

    repo = Path(
        run(
            ["git", "rev-parse", "--show-toplevel"],
            cwd=Path(__file__).resolve().parent,
            capture=True,
        ).stdout.strip()
    )
    nvchecker_config = repo / ".nvchecker.toml"
    versions_file = repo / "home/.chezmoidata/versions.toml"

    run(["nvchecker", "-c", str(nvchecker_config)], cwd=repo)
    names = [
        line.strip()
        for line in run(
            ["nvcmp", "-c", str(nvchecker_config), "-q", "-n"], cwd=repo, capture=True
        ).stdout.splitlines()
        if line.strip()
    ]
    if not names:
        print("No version updates from nvchecker.")
        return

    detected = json.loads((repo / ".nv_new.json").read_text())["data"]
    pinned = tomllib.loads(versions_file.read_text())["versions"]
    content = versions_file.read_text()

    updates: list[tuple[str, str, str]] = []
    unknown: list[str] = []
    for name in names:
        if name not in pinned:
            unknown.append(name)
            continue
        if name not in detected:
            print(f"warning: no nvchecker result for {name}, skipped", file=sys.stderr)
            continue
        old = str(pinned[name])
        new = str(detected[name]["version"])
        if old == new:
            continue
        pattern = rf'^{re.escape(name)}\s*=\s*".*"$'
        content, count = re.subn(
            pattern,
            lambda _match, name=name, new=new: f'{name} = "{new}"',
            content,
            count=1,
            flags=re.MULTILINE,
        )
        if count != 1:
            print(
                f"error: could not replace pinned version for {name}", file=sys.stderr
            )
            sys.exit(1)
        updates.append((name, old, new))

    for name in unknown:
        print(
            f"warning: no pinned version for {name}, skipped (nvtake will not take it)",
            file=sys.stderr,
        )
    if not updates:
        print("No pinned versions to bump.")
        return

    print("Pending version bumps:")
    for name, old, new in updates:
        print(f"  {name}: {old} -> {new}")

    if args.dry_run:
        print("Dry run: no files changed, nothing committed or taken.")
        return

    versions_file.write_text(content)

    relative = versions_file.relative_to(repo)
    subject = "chore(chezmoi): externals: bump pinned versions"
    body = "\n".join(f"- {name}: {old} -> {new}" for name, old, new in updates)
    run(["git", "add", "--", str(relative)], cwd=repo)
    run(["git", "commit", "-m", subject, "-m", body], cwd=repo)
    run(
        ["nvtake", "-c", str(nvchecker_config), *(name for name, _, _ in updates)],
        cwd=repo,
    )

    print("\nDone. Refresh the externals with: chezmoi apply")


if __name__ == "__main__":
    main()

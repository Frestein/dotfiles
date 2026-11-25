#!/usr/bin/env bash
set -euo pipefail

# Path to the file containing the list of files/directories to watch.
# Each line is a shell-style path, possibly using variables like ${XDG_CONFIG_HOME:-$HOME/.config}.
TARGETS_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/chezmoi-watcher/targets"

if [[ ! -f "$TARGETS_FILE" ]]; then
	echo "Targets file not found: $TARGETS_FILE" >&2
	exit 1
fi

# Read the targets file, skip comments and empty lines, and expand shell variables.
WATCH_TARGETS=()
while IFS= read -r line; do
	line="${line%%#*}" # Remove all comments
	line="$(printf '%s' "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')" # Trim leading/trailing whitespace
	[[ -n "$line" ]] || continue

	# Safely expand $VARIABLE and ${VARIABLE:-default} constructs
	expanded=$(eval echo "$line")
	WATCH_TARGETS+=("$expanded")
done <"$TARGETS_FILE"

# Optional list of paths to skip, using the same shell-style syntax as targets.
IGNORE_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/chezmoi-watcher/ignore"
IGNORE_TARGETS=()
if [[ -f "$IGNORE_FILE" ]]; then
	while IFS= read -r line; do
		line="${line%%#*}" # Remove all comments
		line="$(printf '%s' "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')" # Trim leading/trailing whitespace
		[[ -n "$line" ]] || continue

		expanded=$(eval echo "$line")
		IGNORE_TARGETS+=("$expanded")
	done <"$IGNORE_FILE"
fi

# Minimum interval between two events for the same file (debounce)
MIN_INTERVAL=2
declare -A last_event_time

# Cached list of paths managed by chezmoi
managed_cache=()

update_managed_cache() {
	# Fill cache with output of chezmoi managed, reporting failures instead of
	# silently leaving an empty cache.
	local output
	if ! output=$(chezmoi managed 2>&1); then
		echo "Chezmoi managed failed: $output" >&2
		managed_cache=()
		return 1
	fi
	mapfile -t managed_cache <<< "$output"
}

# Check if a relative path is already tracked by chezmoi
is_managed() {
	local rel="$1"
	for m in "${managed_cache[@]}"; do
		[[ "$m" == "$rel" ]] && return 0
	done
	return 1
}

if ! update_managed_cache; then
	echo "Initial managed cache is empty" >&2
fi
echo "Managed cache: ${#managed_cache[@]} entries; bookmarks=$(is_managed '.config/doom/bookmarks.eld' && echo yes || echo no)" >&2

# Add or re-add a file, keeping stderr in the journal for diagnostics.
readd_file() {
	local rel="$1" output
	if output=$(chezmoi re-add "$rel" 2>&1); then
		notify-send -u normal -c "chezmoi" "Chezmoi" "File $rel updated"
	else
		echo "Re-add failed for $rel: $output" >&2
		notify-send -u critical -c "chezmoi" "Chezmoi" "Error during re-add $rel"
	fi
}

add_file() {
	local rel="$1" output
	if output=$(chezmoi add "$rel" 2>&1); then
		notify-send -u normal -c "chezmoi" "Chezmoi" "File $rel added"
		update_managed_cache || true
	else
		echo "Add failed for $rel: $output" >&2
		notify-send -u critical -c "chezmoi" "Chezmoi" "Error during add $rel"
	fi
}

# Check whether a changed file belongs to any of the watched targets.
# For a directory target, any file inside it (recursively) matches.
# For a file target, only the exact file matches.
is_watched() {
	local file="$1"
	for target in "${WATCH_TARGETS[@]}"; do
		if [[ -d "$target" ]]; then
			[[ "$file" == "$target"/* ]] && return 0
		else
			[[ "$file" == "$target" ]] && return 0
		fi
	done
	return 1
}

# Check whether a changed file is explicitly ignored.
# Directories match recursively, plain paths match exactly.
is_ignored() {
	local file="$1"
	for target in "${IGNORE_TARGETS[@]-}"; do
		[[ -n "$target" ]] || continue
		if [[ -d "$target" ]]; then
			[[ "$file" == "$target"/* ]] && return 0
		else
			[[ "$file" == "$target" ]] && return 0
		fi
	done
	return 1
}

# inotifywait needs to watch parent directories. Collect unique parent directories
# from all targets to minimise the number of watches.
declare -A watch_parents
for target in "${WATCH_TARGETS[@]}"; do
	if [[ -d "$target" ]]; then
		watch_parents["$target"]=1
	else
		parent_dir=$(dirname "$target")
		watch_parents["$parent_dir"]=1
	fi
done

watch_dirs=("${!watch_parents[@]}")

# Main watch loop: recursively monitor all relevant parent directories.
inotifywait -m -r -e create -e modify --format '%w%f' "${watch_dirs[@]}" | while read -r changed_file; do
	# Ignore events that are not part of our targets
	if ! is_watched "$changed_file"; then
		continue
	fi

	# We are only interested in files, not directories themselves
	if [[ -d "$changed_file" ]]; then
		continue
	fi

	# Normalise path (resolve symlinks, remove extra slashes) and make it relative to $HOME
	changed_file="$(realpath "$changed_file")"
	if is_ignored "$changed_file"; then
		continue
	fi

	rel_path="${changed_file#"$HOME/"}"
	if [[ -z "$rel_path" ]]; then
		continue
	fi

	# Debounce: skip events that arrive too quickly for the same file
	now=$(date +%s)
	last=${last_event_time["$rel_path"]:-0}
	if ((now - last < MIN_INTERVAL)); then
		continue
	fi
	last_event_time["$rel_path"]=$now

	# File may disappear between the event and now
	if [[ ! -e "$changed_file" ]]; then
		echo "File $changed_file no longer exists, skipping"
		continue
	fi

	# Skip changes that only re-apply chezmoi's own state. `verify` exits 0 when
	# the target already matches the desired state, so re-adding would just churn
	# encrypted sources. If verify fails (e.g. no key in this context), fall
	# through to the normal re-add path.
	if is_managed "$rel_path" && chezmoi verify "$HOME/$rel_path" >/dev/null 2>&1; then
		continue
	fi

	# Trust a fresh source-path lookup over the cached managed list. The cache is
	# built only at startup and can go stale, which would send already-managed
	# files (including encrypted ones) down the `chezmoi add` path.
	src="$(chezmoi source-path "$HOME/$rel_path" 2>/dev/null)" || {
		echo "Source-path failed for $rel_path" >&2
		src=""
	}
	if [[ -n "$src" ]]; then
		if ! is_managed "$rel_path"; then
			echo "Cache miss: $rel_path, source-path: $src" >&2
		fi
		readd_file "$rel_path"
	else
		update_managed_cache || true
		if is_managed "$rel_path"; then
			echo "Source-path was empty for managed file $rel_path" >&2
			readd_file "$rel_path"
		else
			add_file "$rel_path"
		fi
	fi
done

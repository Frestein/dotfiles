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
	line="${line// /}" # Remove all spaces
	[[ -n "$line" ]] || continue

	# Safely expand $VARIABLE and ${VARIABLE:-default} constructs
	expanded=$(eval echo "$line")
	WATCH_TARGETS+=("$expanded")
done <"$TARGETS_FILE"

# Minimum interval between two events for the same file (debounce)
MIN_INTERVAL=2
declare -A last_event_time

# Cached list of paths managed by chezmoi
managed_cache=()

update_managed_cache() {
	# Fill cache with output of chezmoi managed
	mapfile -t managed_cache < <(chezmoi managed 2>/dev/null || true)
}

# Check if a relative path is already tracked by chezmoi
is_managed() {
	local rel="$1"
	for m in "${managed_cache[@]}"; do
		[[ "$m" == "$rel" ]] && return 0
	done
	return 1
}

update_managed_cache

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

	# Update or add the file in chezmoi
	if is_managed "$rel_path"; then
		if chezmoi re-add "$rel_path" 2>/dev/null; then
			notify-send -u normal -c "chezmoi" "Chezmoi" "File $rel_path updated"
		else
			notify-send -u critical -c "chezmoi" "Chezmoi" "Error during re-add $rel_path"
		fi
	else
		if chezmoi add "$rel_path" 2>/dev/null; then
			notify-send -u normal -c "chezmoi" "Chezmoi" "File $rel_path added"
			update_managed_cache
		else
			notify-send -u critical -c "chezmoi" "Chezmoi" "Error during add $rel_path"
		fi
	fi
done

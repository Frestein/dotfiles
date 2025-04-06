#!/usr/bin/env dash

ANDROID_HOME="$HOME/Projects/android/sdk"

FUZZEL_IGNORED_BINDIRS="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"

exit_err() {
  echo "$1" >&2
  exit 1
}

is_bindir_enabled() {
  for ignored in $_ignored_bindirs; do
    if [ "$ignored" = "$1" ]; then
      return 1
    fi
  done
  return 0
}

_fuzzel_exec=fuzzel
if which fuzzel-launch >/dev/null 2>&1; then
  _fuzzel_exec=fuzzel-launch
fi

_ignored_bindirs=""
if [ "$FUZZEL_IGNORED_BINDIRS" != "" ]; then
  _ignored_bindirs=$(echo "$FUZZEL_IGNORED_BINDIRS" | tr ':' ' ' | sort | uniq)
fi

_bindirs=$(echo "$PATH" | tr ':' ' ' | sort | uniq)

_lsdirs=""
for _bindir in $_bindirs; do
  if [ -d "$_bindir" ] && is_bindir_enabled "$_bindir"; then
    _lsdirs="$_lsdirs $_bindir"
  fi
done

if [ "$_lsdirs" != "" ]; then
  _execfile=$(eval "find $_lsdirs -maxdepth 1 -type f -executable -printf '%f\n'" | sort | uniq | "$_fuzzel_exec" -d -p "󰜎 " --counter)

  [ "$_execfile" != "" ] || {
    echo "No executable was selected!"
    exit
  }

  if which "$_execfile"; then
    exec "$_execfile"
  else
    exit_err "No executable: $_execfile"
  fi
else
  exit_err "Failed finding executables!"
fi

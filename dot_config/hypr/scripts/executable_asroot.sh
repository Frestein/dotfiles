#!/usr/bin/env bash

run_with_privileges() {
    local env_vars=(
        "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
        "WAYLAND_DISPLAY=$WAYLAND_DISPLAY"
        "XDG_SESSION_TYPE=$XDG_SESSION_TYPE"
    )

    if command -v doas >/dev/null 2>&1; then
        doas_askpass env "${env_vars[@]}" "$@"
    elif command -v run0 >/dev/null 2>&1; then
        run0 env "${env_vars[@]}" "$@"
    elif command -v sudo >/dev/null 2>&1; then
        sudo -A env "${env_vars[@]}" "$@"
    else
        return 1
    fi
}

run_with_privileges "$@"

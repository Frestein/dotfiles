---
name: hyprland
description: >-
  Use when editing Hyprland configuration, adding or debugging keybinds and
  submaps, inspecting runtime state with hyprctl or hyprctl repl, or when the
  user mentions hyprland.lua, hl.bind, submap, hyprctl, or Hyprland keybind
  behaviour.
---

# Hyprland

Compositor config is Lua: `~/.config/hypr/hyprland.lua` with the `hl.*` API.
Split configs use Lua `require("...")`; there is no `source=` keyword.

Hyprlang is no longer used for the compositor config. It remains a library
used by other tools in the ecosystem (`hyprlock.conf`, `hypridle.conf`,
`hyprpaper.conf`, and similar). Syntax such as `$VAR`, `# hyprlang if`, or
`{{a + b}}` belongs to those tools' configs, not to Hyprland itself.

## Before editing

- Check `hyprctl version` when behaviour is unclear.
- Follow the project's own instructions (`AGENTS.md`, `docs/`, or project
  skills) for where the config lives and how changes are applied.
- Validate the source with the project's tools before applying it. At minimum,
  check Lua syntax and formatting:

  ```sh
  luac -p <config.lua>
  stylua --config-path <project-stylua.toml> --check <config.lua>
  ```

## Keybinds

```lua
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + X", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
end)
```

- Binds execute top to bottom in registration order. Multiple binds on the
  same key all run; use one Lua function when you need ordered side effects.
  Check for duplicates before adding a bind, especially inside submaps.
- **Key names are case-insensitive.** `s` and `S` refer to the same key; the
  shift modifier must be written explicitly as `SHIFT + S`. Binding both `s`
  and `S` in one submap makes a single keypress run both handlers.
- Use `wev` to discover a keysym, or `code:<keycode>` to bind a keycode.
- `hl.unbind("...")` is case-sensitive and must match the exact string used in
  `hl.bind`.
- Keyboard layouts: by default binds use the first configured layout. Set
  `resolve_binds_by_sym = 1` to match the typed symbol instead. Keys must be
  reachable without modifiers (for example AZERTY digits); use keycodes or
  generic key names for such layouts.
- Conditions inside `hl.bind(...)` arguments are evaluated once at config load
  time. Wrap runtime-dependent logic in a function instead.
- Bind callbacks run on the compositor event loop and must not block. Avoid
  `io.popen`, network I/O, clipboard tools (`wl-paste`, `xclip`), sleeps, and
  other long-running work. Use `hl.dsp.exec_cmd(...)` for external commands;
  bound any unavoidable probe with `timeout`.
- Useful flags: `locked`, `repeating`, `release`, `submap_universal`,
  `transparent`, `auto_consuming`, `non_consuming`, `description`, `mouse`.

## Submaps

```lua
hl.bind("ALT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", "reset", function()
  hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind("catchall", hl.dsp.submap("reset"))
end)
```

- The second argument of `hl.define_submap` is a fallback submap used after a
  bound key runs; `"reset"` returns to the global map.
- Always provide a way out: `Escape` / `reset`, or `catchall` for unknown keys.
- Submaps can be nested; define children inside the parent's function.
- `{ submap_universal = true }` keeps a bind active in every submap.
- If stuck in a submap:
  `hyprctl dispatch 'hl.dsp.submap("reset")'`. Add `--instance <id>` when
  several Hyprland instances are running.

## hyprctl

- `hyprctl repl` starts an interactive Lua REPL; `hyprctl repl '<code>'`
  evaluates a string and prints the result through `tostring()`. Exit with
  Ctrl+D. Probe live state instead of guessing:

  ```sh
  hyprctl repl 'hl.get_active_window().class'
  hyprctl repl
  > for i, w in pairs(hl.get_windows()) do print(i, w.class) end
  ```

- `hyprctl eval '<lua>'` executes Lua and returns `ok` or the error.
  `hyprctl dispatch '<call>'` is shorthand for `eval 'hl.dispatch(...)'`.
- `hyprctl reload` reloads the config. `reload full-reset` recreates the whole
  config context; use it only when really necessary.
- Info commands: `binds`, `submap`, `configerrors`,
  `getoption <section.option>`, `clients`, `activewindow`, `workspaces`,
  `monitors`, `version`, `rollinglog`.
- Flags: `-j` for JSON output, `--instance <id>` to select an instance,
  `-r` to force a state refresh after changes. `--batch 'cmd1; cmd2'` groups
  control calls; semicolons inside individual Lua commands must be escaped,
  on top of shell escaping.
- Calls are dispatched synchronously: spamming hyprctl slows the compositor.
  Prefer `--batch` and limit info calls. For live events use the event API,
  not polling.

## Verification checklist

1. `luac -p <config>` and `stylua --config-path <project stylua.toml> --check <config>`.
2. Review the diff for duplicate keys within the same submap before applying.
3. Apply the config using the project's workflow, then `hyprctl reload`.
4. After reload: `hyprctl configerrors`, `hyprctl binds -j`, `hyprctl submap`,
   and `hyprctl repl` probes for runtime values.

## References

Official wiki (raw markdown):

- Binds: https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/configuring/core/binds/_index.md
- Bind flags: https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/configuring/core/binds/flags.md
- Submaps: https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/configuring/core/binds/submaps.md
- Keyboard layouts: https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/configuring/core/binds/keyboard-layouts.md
- Using hyprctl: https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/configuring/core/advanced-configuration/using-hyprctl.md
- hyprlang (other ecosystem tools): https://raw.githubusercontent.com/hyprwm/hyprland-wiki/main/content/hypr-ecosystem/dev/hyprlang.md

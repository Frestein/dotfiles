-- Shared path constants for Hyprland' Lua modules.
-- Lua files loaded with require() have separate local scopes, so modules that
-- need these paths import this table instead of repeating os.getenv() lookups.

local home = os.getenv("HOME")
local config_home = os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")
local state_home = os.getenv("XDG_STATE_HOME") or (home .. "/.local/state")

return {
	home = home,
	config_home = config_home,
	state_home = state_home,
	scripts_path = config_home .. "/hypr/scripts",
	wallpapers_path = config_home .. "/hypr/wallpapers",
}

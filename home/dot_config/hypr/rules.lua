-- Window, Layer, and Workspace rules

-- ===========================================================================
-- Tag Rules
-- ===========================================================================

-- ---------------------------------------------------------------------------
-- Tile
-- ---------------------------------------------------------------------------

hl.window_rule { match = { class = "Timeshift-gtk" }, tag = "+tile" }

hl.window_rule { match = { tag = "tile" }, tile = true }

-- ---------------------------------------------------------------------------
-- Popups
-- ---------------------------------------------------------------------------

-- Window matches shared by the float, center and half-size tag sections below.
-- A match without a `tags` list gets all three tags.
local popups = {
	{ match = { title = "ee-footclient" } },
	{ match = { title = "^(emacs-capture)$" } },
	{ match = { title = "^(Please choose a folder)$" } },
	{ match = { title = "^(Find file.*)$" } },
	{ match = { class = "^(firefox)$", title = "^(Save.*)$" } },
	{ match = { class = "^(firefox)$", title = "^(Enter name of file.*)$" } },
	{ match = { class = "^(firefox)$", title = "(^$)" } },
	{ match = { class = "zenity" } },
	{ match = { class = "nm-connection-editor", title = "(^ $)" }, tags = { "float", "center" } },
	{ match = { class = "gcr-prompter" }, tags = { "float", "center" } },
	{ match = { class = "polkit-gnome-authentication-agent-1" }, tags = { "float", "center" } },
	{
		match = {
			class = "org.qbittorrent.qBittorrent",
			title = "^(Preferences|Open Torrent Files|Download from URLs|About qBittorrent|Torrent Creator|Manage Cookies)",
		},
	},
	{
		match = {
			class = "steam",
			title = "^(Friends List|Список друзей|Steam Settings|Настройки|Добавить стороннюю игру|Настройки раздела|Сведения о системе|Системный отчёт|Среда выполнения Steam — сведения о системе)$",
		},
	},
}

for _, popup in ipairs(popups) do
	for _, tag in ipairs(popup.tags or { "float", "center", "half-size" }) do
		hl.window_rule { match = popup.match, tag = "+" .. tag }
	end
end

-- ---------------------------------------------------------------------------
-- Float
-- ---------------------------------------------------------------------------

-- Floated only
hl.window_rule { match = { title = ".*float.*" }, tag = "+float" }
hl.window_rule { match = { class = "steam", title = "(^$)" }, tag = "+float" }

hl.window_rule { match = { tag = "float" }, float = true }

-- ---------------------------------------------------------------------------
-- Center
-- ---------------------------------------------------------------------------

-- Centered only
hl.window_rule { match = { title = ".*center.*" }, tag = "+center" }
hl.window_rule { match = { class = "Timeshift-gtk" }, tag = "+center" }

hl.window_rule { match = { tag = "center" }, center = true }

-- ---------------------------------------------------------------------------
-- Half-size
-- ---------------------------------------------------------------------------

-- Half-sized only
hl.window_rule { match = { title = ".*half.*" }, tag = "+half-size" }

hl.window_rule { match = { tag = "half-size" }, size = "(monitor_w*0.5) (monitor_h*0.5)" }
hl.window_rule { match = { tag = "three-quarters-size" }, size = "(monitor_w*0.75) (monitor_h*0.75)" }

-- ---------------------------------------------------------------------------
-- Stay focus
-- ---------------------------------------------------------------------------

hl.window_rule { match = { class = "^(firefox)$", title = "(^$)" }, tag = "+stay-focus" }

hl.window_rule { match = { tag = "stay-focus" }, stay_focused = true }

-- ===========================================================================
-- Window Rules
-- ===========================================================================

-- Ignore maximize requests from all apps
hl.window_rule {
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
}

-- Games
-- -- War Thunder
hl.window_rule { match = { class = "^(Loading...)$" }, fullscreen = true }

-- ===========================================================================
-- Workspace Rules
-- ===========================================================================

-- Silent auto start org-agenda on special workspace
hl.window_rule { match = { title = "^org-agenda$" }, workspace = "special:agenda silent" }

-- Game Launchers
hl.window_rule { match = { class = "^(net.lutris.Lutris|steam)$" }, workspace = "6 silent" }

-- Smart border
hl.workspace_rule { workspace = "w[tv1]", border_size = 0 }
hl.window_rule { match = { float = true }, border_size = 2 }

-- ===========================================================================
-- Layer Rules
-- ===========================================================================

-- Disable animations for some layers
hl.layer_rule { match = { namespace = "hyprpicker" }, no_anim = true }
hl.layer_rule { match = { namespace = "selection" }, no_anim = true }

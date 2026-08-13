-- Window, Layer, and Workspace rules

-- ===========================================================================
-- Tag Rules
-- ===========================================================================

-- ---------------------------------------------------------------------------
-- Tile
-- ---------------------------------------------------------------------------

hl.window_rule({ match = { class = "Timeshift-gtk" }, tag = "+tile" })

hl.window_rule({ match = { tag = "tile" }, tile = true })

-- ---------------------------------------------------------------------------
-- Float
-- ---------------------------------------------------------------------------

hl.window_rule({ match = { title = ".*float.*" }, tag = "+float" })
hl.window_rule({ match = { title = "ee-footclient" }, tag = "+float" })
hl.window_rule({ match = { title = "^(emacs-capture)$" }, tag = "+float" })
hl.window_rule({ match = { title = "^(Please choose a folder)$" }, tag = "+float" })
hl.window_rule({ match = { title = "^(Find file.*)$" }, tag = "+float" })
hl.window_rule({ match = { class = "^(firefox)$", title = "^(Save.*)$" }, tag = "+float" })
hl.window_rule({ match = { class = "^(firefox)$", title = "^(Enter name of file.*)$" }, tag = "+float" })
hl.window_rule({ match = { class = "^(firefox)$", title = "(^$)" }, tag = "+float" })
hl.window_rule({ match = { class = "zenity" }, tag = "+float" })
hl.window_rule({ match = { class = "nm-connection-editor", title = "(^ $)" }, tag = "+float" })
hl.window_rule({
	match = {
		class = "org.qbittorrent.qBittorrent",
		title = "^(Preferences|Open Torrent Files|Download from URLs|About qBittorrent|Torrent Creator|Manage Cookies)",
	},
	tag = "+float",
})
hl.window_rule({ match = { class = "gcr-prompter" }, tag = "+float" })
hl.window_rule({ match = { class = "polkit-gnome-authentication-agent-1" }, tag = "+float" })
hl.window_rule({
	match = {
		class = "steam",
		title = "^(Friends List|Список друзей|Steam Settings|Настройки|Добавить стороннюю игру|Настройки раздела|Сведения о системе|Системный отчёт|Среда выполнения Steam — сведения о системе)$",
	},
	tag = "+float",
})
hl.window_rule({ match = { class = "steam", title = "(^$)" }, tag = "+float" })

hl.window_rule({ match = { tag = "float" }, float = true })

-- ---------------------------------------------------------------------------
-- Center
-- ---------------------------------------------------------------------------

hl.window_rule({ match = { title = ".*center.*" }, tag = "+center" })
hl.window_rule({ match = { title = "ee-footclient" }, tag = "+center" })
hl.window_rule({ match = { title = "^(emacs-capture)$" }, tag = "+center" })
hl.window_rule({ match = { title = "^(Please choose a folder)$" }, tag = "+center" })
hl.window_rule({ match = { title = "^(Find file.*)$" }, tag = "+center" })
hl.window_rule({ match = { class = "Timeshift-gtk" }, tag = "+center" })
hl.window_rule({ match = { class = "^(firefox)$", title = "^(Save.*)$" }, tag = "+center" })
hl.window_rule({ match = { class = "^(firefox)$", title = "^(Enter name of file.*)$" }, tag = "+center" })
hl.window_rule({ match = { class = "^(firefox)$", title = "(^$)" }, tag = "+center" })
hl.window_rule({ match = { class = "zenity" }, tag = "+center" })
hl.window_rule({ match = { class = "nm-connection-editor", title = "(^ $)" }, tag = "+center" })
hl.window_rule({
	match = {
		class = "org.qbittorrent.qBittorrent",
		title = "^(Preferences|Open Torrent Files|Download from URLs|About qBittorrent|Torrent Creator|Manage Cookies)",
	},
	tag = "+center",
})
hl.window_rule({ match = { class = "gcr-prompter" }, tag = "+center" })
hl.window_rule({ match = { class = "polkit-gnome-authentication-agent-1" }, tag = "+center" })
hl.window_rule({
	match = {
		class = "steam",
		title = "^(Friends List|Список друзей|Steam Settings|Настройки|Добавить стороннюю игру|Настройки раздела|Сведения о системе|Системный отчёт|Среда выполнения Steam — сведения о системе)$",
	},
	tag = "+center",
})

hl.window_rule({ match = { tag = "center" }, center = true })

-- ---------------------------------------------------------------------------
-- Half-size
-- ---------------------------------------------------------------------------

hl.window_rule({ match = { title = ".*half.*" }, tag = "+half-size" })
hl.window_rule({ match = { title = "ee-footclient" }, tag = "+half-size" })
hl.window_rule({ match = { title = "^(emacs-capture)$" }, tag = "+half-size" })
hl.window_rule({ match = { title = "^(Please choose a folder)$" }, tag = "+half-size" })
hl.window_rule({ match = { title = "^(Find file.*)$" }, tag = "+half-size" })
hl.window_rule({ match = { class = "^(firefox)$", title = "^(Save.*)$" }, tag = "+half-size" })
hl.window_rule({ match = { class = "^(firefox)$", title = "^(Enter name of file.*)$" }, tag = "+half-size" })
hl.window_rule({ match = { class = "^(firefox)$", title = "(^$)" }, tag = "+half-size" })
hl.window_rule({ match = { class = "zenity" }, tag = "+half-size" })
hl.window_rule({
	match = {
		class = "org.qbittorrent.qBittorrent",
		title = "^(Preferences|Open Torrent Files|Download from URLs|About qBittorrent|Torrent Creator|Manage Cookies)",
	},
	tag = "+half-size",
})
hl.window_rule({
	match = {
		class = "steam",
		title = "^(Friends List|Список друзей|Steam Settings|Настройки|Добавить стороннюю игру|Настройки раздела|Сведения о системе|Системный отчёт|Среда выполнения Steam — сведения о системе)$",
	},
	tag = "+half-size",
})

hl.window_rule({ match = { tag = "half-size" }, size = "(monitor_w*0.5) (monitor_h*0.5)" })
hl.window_rule({ match = { tag = "three-quarters-size" }, size = "(monitor_w*0.75) (monitor_h*0.75)" })

-- ---------------------------------------------------------------------------
-- Stay focus
-- ---------------------------------------------------------------------------

hl.window_rule({ match = { class = "^(firefox)$", title = "(^$)" }, tag = "+stay-focus" })

hl.window_rule({ match = { tag = "stay-focus" }, stay_focused = true })

-- ===========================================================================
-- Window Rules
-- ===========================================================================

-- Ignore maximize requests from all apps
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Games
-- -- War Thunder
hl.window_rule({ match = { class = "^(Loading...)$" }, fullscreen = true })

-- ===========================================================================
-- Workspace Rules
-- ===========================================================================

-- Silent auto start org-agenda on special workspace
hl.window_rule({ match = { title = "^org-agenda$" }, workspace = "special:agenda silent" })

-- Game Launchers
hl.window_rule({ match = { class = "^(net.lutris.Lutris|steam)$" }, workspace = "6 silent" })

-- Smart border
hl.workspace_rule({ workspace = "w[tv1]", border_size = 0 })
hl.window_rule({ match = { float = true }, border_size = 2 })

-- ===========================================================================
-- Layer Rules
-- ===========================================================================

-- Disable animations for some layers
hl.layer_rule({ match = { namespace = "hyprpicker" }, no_anim = true })
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })

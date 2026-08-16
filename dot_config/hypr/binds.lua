-- All keybindings and submap definitions

local paths = require("lib.paths")

-- ===========================================================================
-- Helper functions
-- ===========================================================================

local reset_submap = "hyprctl dispatch 'hl.dsp.submap(\"reset\")'" -- Resets submap

-- Helper to reset submap before command
local function with_reset(cmd)
	return reset_submap .. " && " .. cmd
end

-- systemctl --user helper
---@param subcmd string   # systemctl subcommand (e.g., "reload waybar")
---@return string         # Full systemctl --user command
local function scu(subcmd)
	return "systemctl --user " .. subcmd
end

-- Helper to build uwsm app commands
---@param cmd string   # Command to run under uwsm
---@return string      # Full uwsm command
local function uwsm_app(cmd)
	return "uwsm app -- " .. cmd
end

local emacs = "emacsclient -nc"

---@param expr string        # Emacs Lisp expression (without outer quotes)
---@param extra string|nil   # Optional extra arguments (e.g., --frame-parameters=...)
---@return string            # Full emacsclient command
local function emacs_cmd(expr, extra)
	local cmd = emacs .. ' -e "' .. expr .. '"'
	if extra then
		cmd = cmd .. " " .. extra
	end
	return cmd
end

-- ===========================================================================
-- Variables
-- ===========================================================================

-- Apps
local browser = uwsm_app(os.getenv("BROWSER"))
local discord = uwsm_app('goofcord --password-store="gnome-libsecret"')
local telegram = uwsm_app("AyuGram")
local youtube_music = uwsm_app("youtube-music --enable-features=WebRTCPipeWireCapturer --ozone-platform-hint=auto")

-- Emacs
local emacs_agenda = emacs_cmd('(org-agenda nil "d")')
local emacs_capture = emacs_cmd('(org-capture nil "t")', '--frame-parameters="((name . \\"emacs-capture\\"))"')
local emacs_eshell = emacs_cmd('(eshell "γνῶθι σεαυτόν")')
local emacs_ebuku = emacs_cmd("(ebuku)")
local emacs_elfeed = emacs_cmd("(fr/elfeed-open-and-update)")
local emacs_telega = emacs_cmd("(telega)")
local emacs_trashed = emacs_cmd("(trashed)")
local emacs_ibuffer = emacs_cmd("(ibuffer)")
local emacs_dired = emacs_cmd("(dired-jump)")
local emacs_ghostel = emacs_cmd("(ghostel)")
local emacs_pass = emacs_cmd("(pass)")
local emacs_mu4e = emacs_cmd("(=mu4e)")

-- Terminal
local term = "footclient"
local term_calc = "footclient -T 'footclient-center-half-float-calc' qalc"
local term_top = "footclient -T 'footclient-center-half-float-top' btm -b --hide_avg_cpu"
local term_yazi = "footclient -T 'footclient-center-half-float-yazi' yazi"
local term_youtube = "footclient -T 'footclient-center-half-float-yt' yt-x"

-- Dmenu
local dmenu_launcher = "fuzzel -p ' ' -l 15"
local dmenu_clipboard = "cliphist-fuzzel-img"
local dmenu_pass = "tessen"
local dmenu_files = "dmenu_extended_run --no-settings"
local dmenu_launch_as_root = paths.scripts_path .. "/fuzzel/launch_as_root.sh"
local dmenu_switch_window = paths.scripts_path .. "/fuzzel/switch_window.sh"

-- Bar
-- stylua: ignore
local bar_toggle_autohide = scu("is-active --quiet waybar-autohide")
	.. " && " .. scu("stop waybar-autohide")
	.. " || " .. scu("start waybar-autohide")
local bar_toggle_visibility = "pkill -USR1 waybar"
local bar_lock_visibility = paths.scripts_path .. "/toggle_waybar_lock.sh"
local bar_reload_config = scu("reload waybar")
local bar_restart_service = scu("restart waybar")

-- Hyprland scripts
local toggle_monocle_layout = paths.scripts_path .. "/toggle_monocle_layout.sh"
local toggle_bluelight = paths.scripts_path .. "/toggle_bluelight.sh"
local colorpicker = paths.scripts_path .. "/colorpicker.sh"
local kill_active_window = paths.scripts_path .. "/kill_active_window.sh"
local close_special = paths.scripts_path .. "/close_special.sh"
local move_focus = paths.scripts_path .. "/smart_move_focus.sh"
local zoom = require("scripts.zoom")

-- Hyprland behavior
local set_layout_en = "hyprctl switchxkblayout kanata 0" -- Sets english layout

-- ===========================================================================
-- Binds
-- ===========================================================================

-- Apps
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(term))
hl.bind("XF86HomePage", hl.dsp.exec_cmd(browser))
hl.bind("SHIFT + XF86HomePage", hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + Q", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("firefox"))

-- Editor
hl.bind("SUPER + E", hl.dsp.submap("editor"))
hl.define_submap("editor", "reset", function()
	hl.bind("E", hl.dsp.exec_cmd(emacs))
	hl.bind("SHIFT + E", hl.dsp.exec_cmd(emacs_eshell))
	hl.bind("A", hl.dsp.exec_cmd(emacs_agenda))
	hl.bind("C", hl.dsp.exec_cmd(emacs_capture))
	hl.bind("B", hl.dsp.exec_cmd(emacs_ebuku))
	hl.bind("N", hl.dsp.exec_cmd(emacs_elfeed))
	hl.bind("T", hl.dsp.exec_cmd(emacs_telega))
	hl.bind("SHIFT + T", hl.dsp.exec_cmd(emacs_trashed))
	hl.bind("I", hl.dsp.exec_cmd(emacs_ibuffer))
	hl.bind("F", hl.dsp.exec_cmd(emacs_dired))
	hl.bind("S", hl.dsp.exec_cmd(emacs_ghostel))
	hl.bind("P", hl.dsp.exec_cmd(emacs_pass))
	hl.bind("M", hl.dsp.exec_cmd(emacs_mu4e))
	hl.bind("R", hl.dsp.exec_cmd(scu("reload emacs.service")))
	hl.bind("SHIFT + R", hl.dsp.exec_cmd(scu("restart emacs.service")))
	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Scratchpad
hl.bind("XF86Explorer", hl.dsp.workspace.toggle_special("yazi"))
hl.bind("XF86Tools", hl.dsp.workspace.toggle_special("music"))
hl.bind("XF86Calculator", hl.dsp.workspace.toggle_special("calc"))

hl.bind("SUPER + S", hl.dsp.submap("scratchpad"))
hl.define_submap("scratchpad", "reset", function()
	hl.bind("R", hl.dsp.workspace.toggle_special("music"))
	hl.bind("T", hl.dsp.workspace.toggle_special("telega"))
	hl.bind("SHIFT + T", hl.dsp.workspace.toggle_special("telegram"))
	hl.bind("D", hl.dsp.workspace.toggle_special("discord"))
	hl.bind("N", hl.dsp.workspace.toggle_special("elfeed"))
	hl.bind("Y", hl.dsp.workspace.toggle_special("youtube"))
	hl.bind("F", hl.dsp.workspace.toggle_special("yazi"))
	hl.bind("A", hl.dsp.workspace.toggle_special("agenda"))
	hl.bind("C", hl.dsp.workspace.toggle_special("calc"))
	hl.bind("B", hl.dsp.workspace.toggle_special("ebuku"))
	hl.bind("SHIFT + B", hl.dsp.workspace.toggle_special("top"))
	hl.bind("M", hl.dsp.workspace.toggle_special("mu4e"))
	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.workspace_rule({ workspace = "special:music", on_created_empty = youtube_music })
hl.workspace_rule({ workspace = "special:telega", on_created_empty = emacs_telega })
hl.workspace_rule({ workspace = "special:telegram", on_created_empty = telegram })
hl.workspace_rule({ workspace = "special:discord", on_created_empty = discord })
hl.workspace_rule({ workspace = "special:elfeed", on_created_empty = emacs_elfeed })
hl.workspace_rule({ workspace = "special:youtube", on_created_empty = term_youtube })
hl.workspace_rule({ workspace = "special:yazi", on_created_empty = term_yazi })
hl.workspace_rule({ workspace = "special:agenda", on_created_empty = emacs_agenda })
hl.workspace_rule({ workspace = "special:calc", on_created_empty = term_calc })
hl.workspace_rule({ workspace = "special:ebuku", on_created_empty = emacs_ebuku })
hl.workspace_rule({ workspace = "special:top", on_created_empty = term_top })
hl.workspace_rule({ workspace = "special:mu4e", on_created_empty = emacs_mu4e })

-- Applets
hl.bind("CTRL + F1", hl.dsp.exec_cmd("pkill fuzzel || (" .. set_layout_en .. " && " .. dmenu_launcher .. ")"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("pkill fuzzel || (" .. set_layout_en .. " && " .. dmenu_clipboard .. ")"))

hl.bind("SUPER + A", hl.dsp.submap("applets"))
hl.define_submap("applets", function()
	hl.bind("Z", hl.dsp.exec_cmd(with_reset("(" .. set_layout_en .. " && " .. dmenu_pass .. ")")))
	hl.bind("F", hl.dsp.exec_cmd(with_reset("(" .. set_layout_en .. " && " .. dmenu_files .. ")")))
	hl.bind("B", hl.dsp.exec_cmd(with_reset("brightnessctl --dmenu")))
	hl.bind(
		"S",
		hl.dsp.exec_cmd(
			with_reset(
				"pwmenu -l custom --launcher-command \"fuzzel -d --minimal-lines -w 58 -p 'PipeWire ' --placeholder 'Choose...'\""
			)
		)
	)
	hl.bind(
		"SHIFT + S",
		hl.dsp.exec_cmd(
			with_reset('uuctl fuzzel --dmenu -w 100 -p "Select Service " --placeholder "Search..." --minimal-lines')
		)
	)
	hl.bind("R", hl.dsp.exec_cmd(with_reset("(" .. set_layout_en .. " && " .. dmenu_launch_as_root .. ")")))
	hl.bind("W", hl.dsp.exec_cmd(with_reset("(" .. set_layout_en .. " && " .. dmenu_switch_window .. ")")))
	hl.bind("Q", hl.dsp.exec_cmd(with_reset("(" .. set_layout_en .. " && sessionctl --dmenu)")))
	hl.bind("D", hl.dsp.exec_cmd(with_reset("(" .. set_layout_en .. " && downloadctl)")))

	-- Emoji
	hl.bind("E", hl.dsp.submap("emoji"))
	hl.define_submap("emoji", "reset", function()
		hl.bind("E", hl.dsp.exec_cmd("(" .. set_layout_en .. ' && emojictl "Emoji " emoji)'))
		hl.bind("N", hl.dsp.exec_cmd("(" .. set_layout_en .. ' && emojictl "Nerd " nerd_font)'))
		hl.bind("M", hl.dsp.exec_cmd("(" .. set_layout_en .. ' && emojictl "Math " math)'))
		hl.bind("W", hl.dsp.exec_cmd("(" .. set_layout_en .. ' && emojictl "Writer " latin-1_supplement math)'))
		hl.bind("ESCAPE", hl.dsp.submap("reset"))
	end)

	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Hyprland
hl.bind("SUPER + D", hl.dsp.submap("hyprland"))
hl.define_submap("hyprland", function()
	hl.bind("M", hl.dsp.exec_cmd(with_reset(toggle_monocle_layout)))

	-- Session
	hl.bind("S", hl.dsp.submap("session"))
	hl.define_submap("session", "reset", function()
		hl.bind("Q", hl.dsp.exec_cmd("sessionctl --logout"), { locked = true })
		hl.bind("L", hl.dsp.exec_cmd("sessionctl --lock"))
		hl.bind("R", hl.dsp.exec_cmd("sessionctl --reload"))
		hl.bind("ESCAPE", hl.dsp.submap("reset"))
	end)

	-- Bar
	hl.bind("B", hl.dsp.submap("bar"))
	hl.define_submap("bar", "reset", function()
		hl.bind("A", hl.dsp.exec_cmd(bar_toggle_autohide))
		hl.bind("T", hl.dsp.exec_cmd(bar_toggle_visibility))
		hl.bind("SHIFT + T", hl.dsp.exec_cmd(bar_lock_visibility))
		hl.bind("R", hl.dsp.exec_cmd(bar_reload_config))
		hl.bind("SHIFT + R", hl.dsp.exec_cmd(bar_restart_service))
		hl.bind("L", hl.dsp.exec_cmd(bar_lock_visibility))
		hl.bind("ESCAPE", hl.dsp.submap("reset"))
	end)

	-- Wallpaper
	hl.bind("W", hl.dsp.submap("wallpaper"))
	hl.define_submap("wallpaper", function()
		hl.bind("R", hl.dsp.exec_cmd("waypaper --random"))
		hl.bind("ESCAPE", hl.dsp.submap("reset"))
	end)

	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Window Management
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER + C", hl.dsp.exec_cmd(kill_active_window))

-- Mouse binds
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- Drag and move window
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Drag and resize window

-- "Smart" move focus
hl.bind("SUPER + H", hl.dsp.exec_cmd(move_focus .. " l"))
hl.bind("SUPER + J", hl.dsp.exec_cmd(move_focus .. " d"))
hl.bind("SUPER + K", hl.dsp.exec_cmd(move_focus .. " u"))
hl.bind("SUPER + L", hl.dsp.exec_cmd(move_focus .. " r"))

hl.bind("SUPER + W", hl.dsp.submap("window/workspace"))

hl.define_submap("window/workspace", function()
	-- Prev/Next Workspace
	hl.bind("Q", hl.dsp.focus({ workspace = "e-1" }))
	hl.bind("E", hl.dsp.focus({ workspace = "e+1" }))

	-- Workspace Switching
	for i = 1, 10 do
		local key = i == 10 and "0" or tostring(i)
		local ws = i == 10 and "10" or tostring(i)
		hl.bind(
			key,
			hl.dsp.exec_cmd(
				with_reset(close_special .. " ; hyprctl dispatch 'hl.dsp.focus({ workspace = \"" .. ws .. "\" })'")
			)
		)
		hl.bind(
			"SHIFT + " .. key,
			hl.dsp.exec_cmd(with_reset("hyprctl dispatch 'hl.dsp.window.move({ workspace = \"" .. ws .. "\" })'"))
		)
	end

	-- Split, Float
	hl.bind("F", hl.dsp.exec_cmd(with_reset("hyprctl dispatch 'hl.dsp.window.float({ action = \"toggle\" })'")))
	hl.bind("S", hl.dsp.exec_cmd(with_reset("hyprctl dispatch 'hl.dsp.layout(\"togglesplit\")'")))

	-- Move Window
	hl.bind("H", hl.dsp.window.move({ direction = "l" }))
	hl.bind("J", hl.dsp.window.move({ direction = "d" }))
	hl.bind("K", hl.dsp.window.move({ direction = "u" }))
	hl.bind("L", hl.dsp.window.move({ direction = "r" }))

	-- Resize Active Window
	hl.bind("R", hl.dsp.submap("resize"))
	hl.define_submap("resize", function()
		hl.bind("H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
		hl.bind("J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
		hl.bind("K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
		hl.bind("L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
		hl.bind("ESCAPE", hl.dsp.submap("reset"))
	end)

	-- Move Active Window
	hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ x = -50, y = 0, relative = true }), { repeating = true })
	hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ x = 0, y = -50, relative = true }), { repeating = true })
	hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ x = 0, y = 50, relative = true }), { repeating = true })
	hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ x = 50, y = 0, relative = true }), { repeating = true })

	-- Kill Active Window
	hl.bind("C", hl.dsp.exec_cmd(with_reset("hyprctl dispatch 'hl.dsp.window.close({ window = \"active\" })'")))

	-- Group Management
	hl.bind("G", hl.dsp.submap("group"))
	hl.define_submap("group", function()
		hl.bind("T", hl.dsp.group.toggle())
		hl.bind("SHIFT + T", hl.dsp.group.lock_active({ action = "toggle" }))
		hl.bind("H", hl.dsp.group.prev(), { repeating = true })
		hl.bind("J", hl.dsp.group.next(), { repeating = true })
		hl.bind("K", hl.dsp.group.prev(), { repeating = true })
		hl.bind("L", hl.dsp.group.next(), { repeating = true })
		hl.bind("ESCAPE", hl.dsp.submap("reset"))
	end)

	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Workspace Management
-- -- Workspace Switching
for i = 1, 10 do
	local key = i == 10 and "0" or tostring(i)
	local ws = i == 10 and "10" or tostring(i)
	hl.bind(
		"SUPER + " .. key,
		hl.dsp.exec_cmd(close_special .. " ; hyprctl dispatch 'hl.dsp.focus({ workspace = \"" .. ws .. "\" })'")
	)
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
end

-- -- Prev/Next Workspace
hl.bind("SUPER + SHIFT + H", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.focus({ workspace = "e+1" }))

-- -- Alt-Tab
hl.bind(
	"ALT + TAB",
	hl.dsp.exec_cmd(close_special .. " || hyprctl dispatch 'hl.dsp.focus({ workspace = \"previous\" })'")
)

-- Mouse Manipulations
-- -- Workspaces
hl.bind(
	"ALT + mouse_up",
	hl.dsp.exec_cmd(close_special .. " ; hyprctl dispatch 'hl.dsp.focus({ workspace = \"e+1\" })'")
)
hl.bind(
	"ALT + mouse_down",
	hl.dsp.exec_cmd(close_special .. " ; hyprctl dispatch 'hl.dsp.focus({ workspace = \"e-1\" })'")
)

-- -- Groups
hl.bind("ALT + SHIFT + mouse_down", hl.dsp.group.prev())
hl.bind("ALT + SHIFT + mouse_up", hl.dsp.group.next())

-- MPRIS
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

hl.bind("ALT + mouse:276", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("ALT + mouse:275", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("CTRL + mouse:276", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("CTRL + mouse:275", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

-- PipeWire
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("volctl --inc"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("volctl --dec"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("volctl --toggle"), { locked = true })

-- JamesDSP
hl.bind("SUPER + V", hl.dsp.submap("jamesdsp"))
hl.define_submap("jamesdsp", "reset", function()
	hl.bind("T", hl.dsp.exec_cmd("jamesdspctl --toggle"))
	hl.bind("S", hl.dsp.exec_cmd("jamesdspctl --state"))
	hl.bind("C", hl.dsp.exec_cmd("jamesdspctl --choose-preset"))
	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Brightness
hl.bind("SUPER + ALT + H", hl.dsp.exec_cmd("brightnessctl --inc"), { repeating = true })
hl.bind("SUPER + ALT + G", hl.dsp.exec_cmd("brightnessctl --dec"), { repeating = true })

-- Bluelight
hl.bind("SUPER + ALT + B", hl.dsp.exec_cmd(toggle_bluelight), { locked = true })

-- Colorpicker
hl.bind("SUPER + P", hl.dsp.exec_cmd(colorpicker))

-- Screencapture
hl.bind("SUPER + R", hl.dsp.submap("record"))
hl.define_submap("record", "reset", function()
	hl.bind("O", hl.dsp.exec_cmd("gsr-ui-cli toggle-show"))
	hl.bind("P", hl.dsp.exec_cmd("gsr-ui-cli toggle-pause"))
	hl.bind("CTRL + S", hl.dsp.exec_cmd("gsr-ui-cli replay-save"))
	hl.bind("R", hl.dsp.exec_cmd("gsr-ui-cli toggle-record"))
	hl.bind("SHIFT + R", hl.dsp.exec_cmd("gsr-ui-cli toggle-replay"))
	hl.bind("S", hl.dsp.exec_cmd("gsr-ui-cli toggle-stream"))
	hl.bind("F1", hl.dsp.exec_cmd("gsr-ui-cli toggle-show"))
	hl.bind("F2", hl.dsp.exec_cmd("gsr-ui-cli toggle-pause"))
	hl.bind("F3", hl.dsp.exec_cmd("gsr-ui-cli replay-save"))
	hl.bind("F4", hl.dsp.exec_cmd("gsr-ui-cli toggle-record"))
	hl.bind("F5", hl.dsp.exec_cmd("gsr-ui-cli toggle-replay"))
	hl.bind("F6", hl.dsp.exec_cmd("gsr-ui-cli toggle-stream"))
	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Screenshot
hl.bind("PRINT", hl.dsp.submap("screenshot"))
hl.define_submap("screenshot", function()
	hl.bind("RETURN", hl.dsp.exec_cmd(with_reset("screenshot")))
	hl.bind("PRINT", hl.dsp.exec_cmd(with_reset("screenshot --now")))
	hl.bind("S", hl.dsp.exec_cmd(with_reset("screenshot --now")))
	hl.bind("A", hl.dsp.exec_cmd(with_reset("screenshot --active")))
	hl.bind("C", hl.dsp.exec_cmd(with_reset("screenshot --area")))
	for i = 1, 10 do
		local key = i == 10 and "0" or tostring(i)
		hl.bind(key, hl.dsp.exec_cmd(with_reset("screenshot --delay " .. i)))
	end

	-- Edit
	hl.bind("E", hl.dsp.submap("screenshot-edit"))
	hl.define_submap("screenshot-edit", function()
		hl.bind("PRINT", hl.dsp.exec_cmd("screenshot --now --edit"))
		hl.bind("S", hl.dsp.exec_cmd("screenshot --now --edit"))
		hl.bind("A", hl.dsp.exec_cmd("screenshot --active --edit"))
		hl.bind("C", hl.dsp.exec_cmd("screenshot --area --edit"))
		for i = 1, 10 do
			local key = i == 10 and "0" or tostring(i)
			hl.bind(key, hl.dsp.exec_cmd("screenshot --delay " .. i .. " --edit"))
		end
		hl.bind("ESCAPE", hl.dsp.submap("reset"))
	end)

	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Zoom
hl.bind("SUPER + Z", hl.dsp.submap("zoom"))
-- stylua: ignore
hl.define_submap("zoom", function()
	hl.bind("Z", function() zoom(0.5) end, { repeating = true })
	hl.bind("SHIFT + Z", function() zoom(-0.5) end, { repeating = true })
	hl.bind("equal", function() zoom(0.5) end, { repeating = true })
	hl.bind("minus", function() zoom(-0.5) end, { repeating = true })
	hl.bind("R", function() zoom(0) end)
	hl.bind("0", function() zoom(0) end)
	hl.bind("1", function() zoom(1) end)
	hl.bind("2", function() zoom(2) end)
	hl.bind("3", function() zoom(3) end)
	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

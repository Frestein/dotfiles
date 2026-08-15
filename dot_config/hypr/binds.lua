-- All keybindings and submap definitions

local paths = require("lib.paths")

local scu = "systemctl --user"
local emacs = "emacsclient -nc"

-- ===========================================================================
-- Variables
-- ===========================================================================

-- Apps
local browser = "uwsm app -- " .. os.getenv("BROWSER")
local discord = 'uwsm app -- goofcord --password-store="gnome-libsecret"'
local telegram = "uwsm app -- AyuGram"
local music = "uwsm app -- youtube-music --enable-features=WebRTCPipeWireCapturer --ozone-platform-hint=auto"

-- -- Emacs
local emacsAgenda = emacs .. ' -e "(org-agenda nil \\"d\\")"'
local emacsCapture = emacs .. ' -e "(org-capture nil \\"t\\")" --frame-parameters="((name . \\"emacs-capture\\"))"'
local emacsEshell = emacs .. ' -e "(eshell \\"γνῶθι σεαυτόν\\")"'
local emacsEbuku = emacs .. ' -e "(ebuku)"'
local emacsElfeed = emacs .. ' -e "(fr/elfeed-open-and-update)"'
local emacsTelega = emacs .. ' -e "(telega)"'
local emacsTrashed = emacs .. ' -e "(trashed)"'
local emacsIbuffer = emacs .. ' -e "(ibuffer)"'
local emacsDired = emacs .. ' -e "(dired-jump)"'
local emacsGhostel = emacs .. ' -e "(ghostel)"'
local emacsPass = emacs .. ' -e "(pass)"'
local emacsMu4e = emacs .. ' -e "(=mu4e)"'

-- -- Terminal
local terminal = "footclient"
local calc = "footclient -T 'footclient-center-half-float-calc' qalc"
local top = "footclient -T 'footclient-center-half-float-top' btm -b --hide_avg_cpu"
local yazi = "footclient -T 'footclient-center-half-float-yazi' yazi"
local youtube = "footclient -T 'footclient-center-half-float-yt' yt-x"

-- Dmenu
local menu = "fuzzel -p ' ' -l 15"
local clipManager = "cliphist-fuzzel-img"
local pass = "tessen"
local files = "dmenu_extended_run --no-settings"

-- Waybar
local toggleBar = "pkill -USR1 waybar"
local lockBar =
	'LOCK="/run/user/$(id -u)/waybar-autohide.lock"; [ -f "$LOCK" ] && rm -f "$LOCK" || touch "$LOCK"; pkill -SIGRTMIN+8 waybar'
local reloadBar = scu .. " reload waybar"
local restartBar = scu .. " restart waybar"
local toggleBarAutohide = scu
	.. " is-active --quiet waybar-autohide && "
	.. scu
	.. " stop waybar-autohide || "
	.. scu
	.. " start waybar-autohide"

-- Hyprland' scripts
local toggleMonocleLayout = paths.scripts_path .. "/toggle_monocle_layout.sh"
local toggleBluelight = paths.scripts_path .. "/toggle_bluelight.sh"
local colorpicker = paths.scripts_path .. "/colorpicker.sh"
local killActiveWindow = paths.scripts_path .. "/kill_active_window.sh"
local closeSpecial = paths.scripts_path .. "/close_special.sh"
local smartMoveFocus = paths.scripts_path .. "/smart_move_focus.sh"
local launchAsRoot = paths.scripts_path .. "/fuzzel/launch_as_root.sh"
local switchWindow = paths.scripts_path .. "/fuzzel/switch_window.sh"

-- Hyprland' behavior
local enLayout = "hyprctl switchxkblayout kanata 0" -- Sets english layout
local resetSubmap = "hyprctl dispatch 'hl.dsp.submap(\"reset\")'" -- Resets submap

-- ===========================================================================
-- Functions
-- ===========================================================================

-- Helper to reset submap before command
local function withReset(cmd)
	return resetSubmap .. " && " .. cmd
end

-- ===========================================================================
-- Binds
-- ===========================================================================

-- Apps
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("XF86HomePage", hl.dsp.exec_cmd(browser))
hl.bind("SHIFT + XF86HomePage", hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + Q", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("firefox"))

-- Editor
hl.bind("SUPER + E", hl.dsp.submap("editor"))

hl.define_submap("editor", "reset", function()
	hl.bind("E", hl.dsp.exec_cmd(emacs))
	hl.bind("SHIFT + E", hl.dsp.exec_cmd(emacsEshell))
	hl.bind("A", hl.dsp.exec_cmd(emacsAgenda))
	hl.bind("C", hl.dsp.exec_cmd(emacsCapture))
	hl.bind("B", hl.dsp.exec_cmd(emacsEbuku))
	hl.bind("N", hl.dsp.exec_cmd(emacsElfeed))
	hl.bind("T", hl.dsp.exec_cmd(emacsTelega))
	hl.bind("SHIFT + T", hl.dsp.exec_cmd(emacsTrashed))
	hl.bind("I", hl.dsp.exec_cmd(emacsIbuffer))
	hl.bind("F", hl.dsp.exec_cmd(emacsDired))
	hl.bind("S", hl.dsp.exec_cmd(emacsGhostel))
	hl.bind("P", hl.dsp.exec_cmd(emacsPass))
	hl.bind("M", hl.dsp.exec_cmd(emacsMu4e))
	hl.bind("R", hl.dsp.exec_cmd(scu .. " reload emacs.service"))
	hl.bind("SHIFT + R", hl.dsp.exec_cmd(scu .. " restart emacs.service"))

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

hl.workspace_rule({ workspace = "special:music", on_created_empty = music })
hl.workspace_rule({ workspace = "special:telega", on_created_empty = emacsTelega })
hl.workspace_rule({ workspace = "special:telegram", on_created_empty = telegram })
hl.workspace_rule({ workspace = "special:discord", on_created_empty = discord })
hl.workspace_rule({ workspace = "special:elfeed", on_created_empty = emacsElfeed })
hl.workspace_rule({ workspace = "special:youtube", on_created_empty = youtube })
hl.workspace_rule({ workspace = "special:yazi", on_created_empty = yazi })
hl.workspace_rule({ workspace = "special:agenda", on_created_empty = emacsAgenda })
hl.workspace_rule({ workspace = "special:calc", on_created_empty = calc })
hl.workspace_rule({ workspace = "special:ebuku", on_created_empty = emacsEbuku })
hl.workspace_rule({ workspace = "special:top", on_created_empty = top })
hl.workspace_rule({ workspace = "special:mu4e", on_created_empty = emacsMu4e })

-- Applets
hl.bind("CTRL + F1", hl.dsp.exec_cmd("pkill fuzzel || (" .. enLayout .. " && " .. menu .. ")"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("pkill fuzzel || (" .. enLayout .. " && " .. clipManager .. ")"))

hl.bind("SUPER + A", hl.dsp.submap("applets"))

hl.define_submap("applets", function()
	hl.bind("Z", hl.dsp.exec_cmd(withReset("(" .. enLayout .. " && " .. pass .. ")")))
	hl.bind("F", hl.dsp.exec_cmd(withReset("(" .. enLayout .. " && " .. files .. ")")))
	hl.bind("B", hl.dsp.exec_cmd(withReset("brightnessctl --dmenu")))
	hl.bind(
		"S",
		hl.dsp.exec_cmd(
			withReset(
				"pwmenu -l custom --launcher-command \"fuzzel -d --minimal-lines -w 58 -p 'PipeWire ' --placeholder 'Choose...'\""
			)
		)
	)
	hl.bind(
		"SHIFT + S",
		hl.dsp.exec_cmd(
			withReset('uuctl fuzzel --dmenu -w 100 -p "Select Service " --placeholder "Search..." --minimal-lines')
		)
	)
	hl.bind("R", hl.dsp.exec_cmd(withReset("(" .. enLayout .. " && " .. launchAsRoot .. ")")))
	hl.bind("W", hl.dsp.exec_cmd(withReset("(" .. enLayout .. " && " .. switchWindow .. ")")))
	hl.bind("Q", hl.dsp.exec_cmd(withReset("(" .. enLayout .. " && sessionctl --dmenu)")))
	hl.bind("D", hl.dsp.exec_cmd(withReset("(" .. enLayout .. " && downloadctl)")))

	-- Emoji sub-submap
	hl.bind("E", hl.dsp.submap("emoji"))

	hl.define_submap("emoji", function()
		hl.bind("E", hl.dsp.exec_cmd(withReset("(" .. enLayout .. ' && emojictl "😃 " emoji)')))
		hl.bind("N", hl.dsp.exec_cmd(withReset("(" .. enLayout .. ' && emojictl " " nerd_font)')))
		hl.bind("M", hl.dsp.exec_cmd(withReset("(" .. enLayout .. ' && emojictl "Math " math)')))
		hl.bind("W", hl.dsp.exec_cmd(withReset("(" .. enLayout .. ' && emojictl "Writer " latin-1_supplement math)')))

		hl.bind("ESCAPE", hl.dsp.submap("applets"))
	end)

	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Hyprland
hl.bind("SUPER + D", hl.dsp.submap("hyprland"))

hl.define_submap("hyprland", function()
	-- Session sub-submap
	hl.bind("S", hl.dsp.submap("session"))

	hl.define_submap("session", function()
		hl.bind("Q", hl.dsp.exec_cmd(withReset("sessionctl --logout")), { locked = true })
		hl.bind("L", hl.dsp.exec_cmd(withReset("sessionctl --lock")))
		hl.bind("R", hl.dsp.exec_cmd(withReset("sessionctl --reload")))

		hl.bind("ESCAPE", hl.dsp.submap("reset"))
	end)

	hl.bind("M", hl.dsp.exec_cmd(withReset(toggleMonocleLayout)))

	-- Bar sub-submap
	hl.bind("B", hl.dsp.submap("bar"))

	hl.define_submap("bar", function()
		hl.bind("A", hl.dsp.exec_cmd(withReset(toggleBarAutohide)))
		hl.bind("T", hl.dsp.exec_cmd(withReset(toggleBar)))
		hl.bind("SHIFT + T", hl.dsp.exec_cmd(withReset(lockBar)))
		hl.bind("R", hl.dsp.exec_cmd(withReset(reloadBar)))
		hl.bind("SHIFT + R", hl.dsp.exec_cmd(withReset(restartBar)))
		hl.bind("L", hl.dsp.exec_cmd(withReset(lockBar)))

		hl.bind("ESCAPE", hl.dsp.submap("reset"))
	end)

	-- Wallpaper sub-submap
	hl.bind("W", hl.dsp.submap("wallpaper"))

	hl.define_submap("wallpaper", function()
		hl.bind("R", hl.dsp.exec_cmd("waypaper --random"))

		hl.bind("ESCAPE", hl.dsp.submap("reset"))
	end)

	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Window Management
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER + C", hl.dsp.exec_cmd(killActiveWindow))

-- Mouse binds
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- Drag and move window
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Drag and resize window

-- "Smart" move focus
hl.bind("SUPER + H", hl.dsp.exec_cmd(smartMoveFocus .. " l"))
hl.bind("SUPER + J", hl.dsp.exec_cmd(smartMoveFocus .. " d"))
hl.bind("SUPER + K", hl.dsp.exec_cmd(smartMoveFocus .. " u"))
hl.bind("SUPER + L", hl.dsp.exec_cmd(smartMoveFocus .. " r"))

hl.bind("SUPER + W", hl.dsp.submap("window/workspace"))

hl.define_submap("window/workspace", function()
	-- Prev/Next Workspace
	hl.bind("Q", hl.dsp.focus({ workspace = "e-1" }))
	hl.bind("E", hl.dsp.focus({ workspace = "e+1" }))

	-- Split, Float
	hl.bind("F", hl.dsp.exec_cmd(withReset("hyprctl dispatch 'hl.dsp.window.float({ action = \"toggle\" })'")))
	hl.bind("S", hl.dsp.exec_cmd(withReset("hyprctl dispatch 'hl.dsp.layout(\"togglesplit\")'")))

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
		hl.dsp.exec_cmd(closeSpecial .. " ; hyprctl dispatch 'hl.dsp.focus({ workspace = \"" .. ws .. "\" })'")
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
	hl.dsp.exec_cmd(closeSpecial .. " || hyprctl dispatch 'hl.dsp.focus({ workspace = \"previous\" })'")
)

-- Mouse Manipulations
-- -- Workspaces
hl.bind(
	"ALT + mouse_up",
	hl.dsp.exec_cmd(closeSpecial .. " ; hyprctl dispatch 'hl.dsp.focus({ workspace = \"e+1\" })'")
)
hl.bind(
	"ALT + mouse_down",
	hl.dsp.exec_cmd(closeSpecial .. " ; hyprctl dispatch 'hl.dsp.focus({ workspace = \"e-1\" })'")
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

hl.define_submap("jamesdsp", function()
	hl.bind("T", hl.dsp.exec_cmd(withReset("jamesdspctl --toggle")))
	hl.bind("S", hl.dsp.exec_cmd(withReset("jamesdspctl --state")))
	hl.bind("C", hl.dsp.exec_cmd(withReset("jamesdspctl --choose-preset")))

	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Brightness
hl.bind("SUPER + ALT + H", hl.dsp.exec_cmd("brightnessctl --inc"), { repeating = true })
hl.bind("SUPER + ALT + G", hl.dsp.exec_cmd("brightnessctl --dec"), { repeating = true })

-- Bluelight
hl.bind("SUPER + ALT + B", hl.dsp.exec_cmd(toggleBluelight), { locked = true })

-- Colorpicker
hl.bind("SUPER + P", hl.dsp.exec_cmd(colorpicker))

-- Screencapture
hl.bind("SUPER + R", hl.dsp.submap("record"))

local gsr = "gsr-ui-cli"

hl.define_submap("record", function()
	hl.bind("O", hl.dsp.exec_cmd(withReset(gsr .. " toggle-show")))
	hl.bind("P", hl.dsp.exec_cmd(withReset(gsr .. " toggle-pause")))
	hl.bind("CTRL + S", hl.dsp.exec_cmd(withReset(gsr .. " replay-save")))
	hl.bind("R", hl.dsp.exec_cmd(withReset(gsr .. " toggle-record")))
	hl.bind("SHIFT + R", hl.dsp.exec_cmd(withReset(gsr .. " toggle-replay")))
	hl.bind("S", hl.dsp.exec_cmd(withReset(gsr .. " toggle-stream")))
	hl.bind("F1", hl.dsp.exec_cmd(withReset(gsr .. " toggle-show")))
	hl.bind("F2", hl.dsp.exec_cmd(withReset(gsr .. " toggle-pause")))
	hl.bind("F3", hl.dsp.exec_cmd(withReset(gsr .. " replay-save")))
	hl.bind("F4", hl.dsp.exec_cmd(withReset(gsr .. " toggle-record")))
	hl.bind("F5", hl.dsp.exec_cmd(withReset(gsr .. " toggle-replay")))
	hl.bind("F6", hl.dsp.exec_cmd(withReset(gsr .. " toggle-stream")))

	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Screenshot
hl.bind("PRINT", hl.dsp.submap("screenshot"))

local scmd = "screenshot"

hl.define_submap("screenshot", function()
	hl.bind("RETURN", hl.dsp.exec_cmd(withReset(scmd)))
	hl.bind("PRINT", hl.dsp.exec_cmd(withReset(scmd .. " --now")))
	hl.bind("S", hl.dsp.exec_cmd(withReset(scmd .. " --now")))
	hl.bind("A", hl.dsp.exec_cmd(withReset(scmd .. " --active")))
	hl.bind("C", hl.dsp.exec_cmd(withReset(scmd .. " --area")))

	for i = 1, 10 do
		local key = i == 10 and "0" or tostring(i)
		hl.bind(key, hl.dsp.exec_cmd(withReset(scmd .. " --delay " .. i)))
	end

	-- Edit sub-submap
	hl.bind("E", hl.dsp.submap("screenshot-edit"))

	hl.define_submap("screenshot-edit", function()
		hl.bind("PRINT", hl.dsp.exec_cmd(withReset(scmd .. " --now --edit")))
		hl.bind("S", hl.dsp.exec_cmd(withReset(scmd .. " --now --edit")))
		hl.bind("A", hl.dsp.exec_cmd(withReset(scmd .. " --active --edit")))
		hl.bind("C", hl.dsp.exec_cmd(withReset(scmd .. " --area --edit")))

		for i = 1, 10 do
			local key = i == 10 and "0" or tostring(i)
			hl.bind(key, hl.dsp.exec_cmd(withReset(scmd .. " --delay " .. i .. " --edit")))
		end

		hl.bind("ESCAPE", hl.dsp.submap("screenshot"))
	end)

	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Zoom
hl.bind("SUPER + Z", hl.dsp.submap("zoom"))

local zoom_cmd =
	"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')"
local zoom_cmd_down =
	"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 0.9}')"

hl.define_submap("zoom", function()
	hl.bind("mouse_down", hl.dsp.exec_cmd(zoom_cmd))
	hl.bind("mouse_up", hl.dsp.exec_cmd(zoom_cmd_down))
	hl.bind("Z", hl.dsp.exec_cmd(zoom_cmd), { repeating = true })
	hl.bind("X", hl.dsp.exec_cmd(zoom_cmd_down), { repeating = true })
	hl.bind("C", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))
	hl.bind("UP", hl.dsp.exec_cmd(zoom_cmd), { repeating = true })
	hl.bind("DOWN", hl.dsp.exec_cmd(zoom_cmd_down), { repeating = true })
	hl.bind("0", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))
	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

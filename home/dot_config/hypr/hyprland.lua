require "autostart"
require "rules"
require "binds"

local colors = require "themes.gruvbox-dark"

hl.monitor {
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
}

hl.config {
	general = {
		-- I didn’t fucking pay for pixels to sit idle
		gaps_in = 0,
		gaps_out = 0,

		-- Border
		resize_on_border = true,
		border_size = 2,
		col = {
			active_border = colors.active_border,
			inactive_border = colors.inactive_border,
			nogroup_border_active = colors.active_border,
			nogroup_border = colors.inactive_border,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	-- FIX: Broken after rewriting groups in Hyprland
	group = {
		col = {
			border_active = colors.group_active_border,
			border_inactive = colors.group_inactive_border,
			border_locked_active = colors.group_locked_active_border,
			border_locked_inactive = colors.group_locked_inactive_border,
		},
		groupbar = {
			font_size = 10,
			col = {
				active = colors.group_bar_active_border,
				inactive = colors.group_bar_inactive_border,
				locked_active = colors.group_bar_locked_active_border,
				locked_inactive = colors.group_bar_locked_inactive_border,
			},
		},
	},

	input = {
		-- My keyboard setup
		kb_layout = "us,ru",
		kb_variant = ",",
		kb_model = "pc104",
		kb_options = "grp:win_space_toggle",
		kb_rules = "",

		sensitivity = -1.0,

		-- Fast scroll on mid mouse button that works everywhere
		scroll_method = "on_button_down",
		scroll_button = 274,
	},

	cursor = {
		-- Good addition for my work-first focus
		inactive_timeout = 5,
	},

	binds = {
		-- Alt-Tab
		allow_workspace_cycles = true,
	},

	-- Useless shit for cool kiddies
	animations = {
		enabled = false,
	},

	ecosystem = {
		-- IDGAF
		no_update_news = true,
		no_donation_nag = true,
	},

	misc = {
		-- Fuck you, I prefer womans with big boobas and thicc thighs
		disable_splash_rendering = true,
		disable_hyprland_logo = true,

		-- Almost a killer feature, but still shit
		enable_swallow = true,
		swallow_regex = "^(foot.*)$",
	},
}

hl.device {
	name = "kanata",
	repeat_delay = 250,
}

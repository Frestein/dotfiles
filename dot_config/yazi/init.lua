--------------------------------------------------------------------------------
--                               Configurations                               --
--------------------------------------------------------------------------------

-- Borders
require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.PLAIN,
})

-- "light" | "dark"
local gruvbox_theme = require("yatline-gruvbox"):setup("dark")

require("yatline"):setup({
	theme = gruvbox_theme,

	permissions_t_fg = "green",
	permissions_r_fg = "yellow",
	permissions_w_fg = "red",
	permissions_x_fg = "cyan",
	permissions_s_fg = "darkgray",

	tab_width = 20,
	tab_use_inverse = false,

	selected = { icon = "󰻭", fg = "yellow" },
	copied = { icon = "", fg = "green" },
	cut = { icon = "", fg = "red" },

	total = { icon = "󰮍", fg = "yellow" },
	succ = { icon = "", fg = "green" },
	fail = { icon = "", fg = "red" },
	found = { icon = "󰮕", fg = "blue" },
	processed = { icon = "󰐍", fg = "green" },

	show_background = true,

	display_header_line = true,
	display_status_line = true,

	header_line = {
		left = {
			section_a = {},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {},
			section_b = {},
			section_c = {},
		},
	},

	status_line = {
		left = {
			section_a = {
				{ type = "string", custom = false, name = "tab_mode" },
			},
			section_b = {
				{ type = "string", custom = false, name = "hovered_name" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_size" },
			},
		},
		right = {
			section_a = {
				{ type = "line", custom = false, name = "tabs", params = { "right" } },
			},
			section_b = {},
			section_c = {
				{ type = "string", custom = false, name = "cursor_position" },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
	},
})

local githead_config = {
	order = {
		"__spacer__",
		"branch",
		"remote",
		"__spacer__",
		"tag",
		"__spacer__",
		"commit",
		"__spacer__",
		"stashes",
		"__spacer__",
		"state",
		"__spacer__",
		"staged",
		"__spacer__",
		"unstaged",
		"__spacer__",
		"untracked",
		"__spacer__",
		"behind_ahead_remote",
	},

	show_numbers = true,

	show_branch = true,
	branch_prefix = "",
	branch_color = "bright blue",
	branch_symbol = " ",
	branch_borders = "",

	show_remote_branch = true,
	always_show_remote_branch = false,
	always_show_remote_repo = true,
	remote_branch_prefix = ":",
	remote_branch_color = "bright magenta",

	show_tag = true,
	always_show_tag = false,
	tag_color = "bright yellow",
	tag_symbol = "󰓼 ",

	show_commit = true,
	always_show_commit = false,
	commit_color = "bright green",
	commit_symbol = " ",

	show_behind_ahead_remote = true,
	behind_remote_color = "bright red",
	behind_remote_symbol = " ",
	ahead_remote_color = "bright yellow",
	ahead_remote_symbol = " ",

	show_stashes = true,
	stashes_color = "bright magenta",
	stashes_symbol = "󰏦 ",

	show_state = true,
	show_state_prefix = true,
	state_color = "bright red",
	state_symbol = "~",

	show_staged = true,
	staged_color = "bright green",
	staged_symbol = "󰐙 ",

	show_unstaged = true,
	unstaged_color = "bright yellow",
	unstaged_symbol = "󰗖 ",

	show_untracked = true,
	untracked_color = "bright gray",
	untracked_symbol = " ",
}

-- Tools
require("githead"):setup(githead_config)
require("git"):setup()
require("recycle-bin"):setup()
require("bookmarks"):setup({
	persist = "vim",
	desc_format = "parent",
	file_pick_mode = "parent",
})
require("smart-enter"):setup({
	open_multi = true,
})
require("folder-rules"):setup()

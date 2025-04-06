--------------------------------------------------------------------------------
--                               Configurations                               --
--------------------------------------------------------------------------------

-- Borders
require("full-border"):setup()

-- "light" | "dark"
local gruvbox_theme = require("yatline-gruvbox"):setup("dark")

gruvbox_theme.section_separator = { open = "", close = "" }
gruvbox_theme.part_separator = { open = "", close = "" }
gruvbox_theme.inverse_separator = { open = "", close = "" }
gruvbox_theme.style_c = { fg = "gray" }

-- Tabline and statusline
require("yatline"):setup({
	theme = gruvbox_theme,

	section_separator = { open = "", close = "" },
	part_separator = { open = "", close = "" },
	inverse_separator = { open = "", close = "" },

	style_a = {
		fg = "black",
		bg_mode = {
			normal = "blue",
			select = "magenta",
			un_set = "yellow",
		},
	},
	style_b = { bg = "black", fg = "lightgray" },
	style_c = { fg = "gray" },

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
			section_a = {
				{ type = "line", custom = false, name = "tabs", params = { "left" } },
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "date", params = { "%a, %b %d %Y" } },
			},
			section_b = {},
			section_c = {
				{ type = "coloreds", custom = false, name = "task_states" },
			},
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
				{ type = "coloreds", custom = false, name = "githead" },
			},
		},
		right = {
			section_a = {
				{
					type = "string",
					custom = false,
					name = "cursor_position",
				},
			},
			section_b = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
			},
			section_c = {
				{ type = "coloreds", custom = false, name = "count" },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
	},
})

-- Yatline ad-dons
require("yatline-githead"):setup({
	show_branch = true,
	branch_prefix = "",
	prefix_color = "white",
	branch_color = "blue",
	branch_symbol = "",
	branch_borders = "",

	commit_color = "bright magenta",
	commit_symbol = " ",

	show_stashes = true,
	stashes_color = "bright magenta",
	stashes_symbol = " ",

	show_state = true,
	show_state_prefix = true,
	state_color = "red",
	state_symbol = "~",

	show_staged = true,
	staged_color = "bright yellow",
	staged_symbol = " ",

	show_unstaged = true,
	unstaged_color = "bright yellow",
	unstaged_symbol = "󰗖 ",

	show_untracked = true,
	untracked_color = "blue",
	untracked_symbol = " ",
})

-- Tools
require("git"):setup()
require("bookmarks"):setup({
	persist = "vim",
	desc_format = "parent",
	file_pick_mode = "parent",
})
require("smart-enter"):setup({
	open_multi = true,
})
require("folder-rules"):setup()

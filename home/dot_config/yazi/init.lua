--------------------------------------------------------------------------------
--                               Configurations                               --
--------------------------------------------------------------------------------

-- Borders
require("full-border"):setup {
	-- Available values: "plain", "rounded"
	set = "plain",
}

-- INFO: Use full mode indicator
-- https://github.com/sxyazi/yazi/issues/3332#issuecomment-3533974507
function Status:mode()
	local mode = tostring(self._tab.mode):upper()

	local style = self:style()
	return ui.Line {
		ui.Span(th.status.sep_left.open):fg(style.main:bg()):bg "reset",
		ui.Span(" " .. mode .. " "):style(style.main),
		ui.Span(th.status.sep_left.close):fg(style.main:bg()):bg(style.alt:bg()),
	}
end

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
require("smart-enter"):setup {
	open_multi = true,
}
require("folder-rules"):setup()

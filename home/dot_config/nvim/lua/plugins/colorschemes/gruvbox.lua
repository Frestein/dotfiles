local function set_color(hl_group, fg_hl_name, bg_hl_name)
	local hl_fg = vim.api.nvim_get_hl(0, { name = fg_hl_name }).fg
	local hl_bg = vim.api.nvim_get_hl(0, { name = bg_hl_name }).bg

	vim.api.nvim_set_hl(0, hl_group, { fg = hl_fg, bg = hl_bg })
end

local mode_to_color = {
	i = "GruvboxBlue",
	ic = "GruvboxBlue",
	n = "GruvboxGray",
	v = "GruvboxOrange",
	V = "GruvboxOrange",
	["\22"] = "GruvboxOrange", -- visual block mode Ctrl-V
	R = "GruvboxRed",
	Rv = "GruvboxRed",
	c = "GruvboxGreen",
}

vim.api.nvim_create_autocmd("ModeChanged", {
	callback = function(args)
		local new_mode = args.match:match ":(.+)$"
		local fg_hl = mode_to_color[new_mode] or "GruvboxGray"
		set_color("ColorfulWinSep", fg_hl, "Normal")
	end,
})

return {
	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			overrides = {
				DiagnosticSignOk = { link = "GruvboxGreen" },
				DiagnosticSignWarn = { link = "GruvboxYellow" },
				DiagnosticSignError = { link = "GruvboxRed" },
				DiagnosticSignInfo = { link = "GruvboxBlue" },
				DiagnosticSignHint = { link = "GruvboxAqua" },
				TodoSignFIX = { link = "TodoFgFIX" },
				TodoSignWARN = { link = "TodoFgWARN" },
				TodoSignHACK = { link = "TodoFgHACK" },
				TodoSignPERF = { link = "TodoFgPERF" },
				TodoSignTEST = { link = "TodoFgTEST" },
				TodoSignTODO = { link = "TodoFgTODO" },
				TodoSignNOTE = { link = "TodoFgNOTE" },
				StatusLine = { link = "ColorColumn" },
				-- WinBar = { link = "GruvboxFg4" },
				-- WinBarNC = { link = "GruvboxFg4" },
				-- NvimSeparator = { fg = colors.dark4 },
				-- StatusLineNC = {
				-- 	fg = colors.light4,
				-- 	bg = colors.dark0,
				-- },
				-- FloatBorder = {
				-- 	fg = colors.light4,
				-- 	bg = colors.dark0,
				-- },
				QuickFixLine = { link = "Visual" },
				--- mini.files ---
				-- MiniFilesTitle = {
				-- 	fg = colors.light4,
				-- 	bg = colors.dark0,
				-- },
				-- MiniFilesTitleFocused = {
				-- 	fg = colors.light2,
				-- 	bg = colors.dark0,
				-- },
				--- foldtext.lua ---
				-- FoldedSpace = {
				-- 	fg = "NONE",
				-- 	bg = "NONE",
				-- },
				-- FoldedIcon = {
				-- 	fg = "NONE",
				-- },
				-- FoldedText = {
				-- 	bg = "NONE",
				-- 	fg = colors.light4,
				-- 	italic = true,
				-- },
				--- trouble.nvim ---
				-- TroubleStatusline1 = { link = "Normal" },
				-- TroubleSeparatorHighlight = { fg = colors.bright_yellow, bg = colors.dark4 },
				--- colorful-winsep.nvim ---
				ColorfulWinSep = { link = "GruvboxGray" },
				--- snacks.nvim ---
				SnacksPickerDir = { link = "GruvboxGray" },
				SnacksPickerPathHidden = { link = "GruvboxGray" },
				SnacksPickerGitStatusUntracked = { link = "GruvboxGray" },
				SnacksPicker = { link = "Normal" },
				SnacksPickerBorder = { link = "Grey" },
				SnacksPickerTitle = { link = "Title" },
				SnacksPickerFooter = { link = "SnacksPickerTitle" },
				SnacksPickerPrompt = { link = "Orange" },
				SnacksPickerInputCursorLine = { link = "Normal" },
				SnacksPickerToggle = { link = "CursorLine" },
				SnacksPickerBufFlags = { link = "Grey" },
				SnacksPickerSelected = { link = "Aqua" },
				SnacksPickerKeymapRhs = { link = "Grey" },
				SnacksIndentScope = { link = "GruvboxGray" },
				SnacksIndentChunk = { link = "GruvboxGray" },
				--- noice.nvim ---
				NoiceLspProgressTitle = {
					link = "Comment",
				},
				--- lazy.nvim  ---
				LazyUpdates = {
					link = "GruvboxGreen",
				},
				--- highlight-undo.nvim ---
				HighlightUndo = {
					link = "DiffChange",
				},
				--- gitsigns.nvim ---
				GitSignsCurrentLineBlame = { link = "Comment" },
				--- symbols-usage.nvim ---
				SymbolUsageContent = { link = "Comment", italic = true },
				SymbolUsageRef = { link = "Function", italic = true },
				SymbolUsageDef = { link = "Type", italic = true },
				SymbolUsageImpl = { link = "Keyword", italic = true },
				--- trouble.nvim ---
				TroubleCount = { link = "GruvboxPurple" },
				TroubleCode = { link = "GruvboxFg0" },
				TroubleWarning = { link = "GruvboxOrange" },
				TroubleSignWarning = { link = "DiagnosticWarn" },
				TroubleTextWarning = { link = "GruvboxFg0" },
				TroublePreview = { link = "GruvboxRed" },
				TroubleSource = { link = "GruvboxBlue" },
				TroubleSignHint = { link = "DiagnosticHint" },
				TroubleTextHint = { link = "GruvboxFg0" },
				TroubleHint = { link = "GruvboxOrange" },
				TroubleSignOther = { link = "DiagnosticNormal" },
				TroubleSignInformation = { link = "GruvboxFg0" },
				TroubleTextInformation = { link = "GruvboxFg0" },
				TroubleInformation = { link = "GruvboxFg0" },
				TroubleError = { link = "GruvboxRed" },
				TroubleTextError = { link = "GruvboxFg0" },
				TroubleSignError = { link = "DiagnosticError" },
				TroubleText = { link = "GruvboxFg0" },
				TroubleFile = { link = "GruvboxYellow" },
				TroubleFoldIcon = { link = "Folded" },
				TroubleNormal = { link = "GruvboxFg0" },
				TroubleLocation = { link = "GruvboxRed" },
				TroubleIndent = { link = "Comment" },
			},
		},
	},

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},
}

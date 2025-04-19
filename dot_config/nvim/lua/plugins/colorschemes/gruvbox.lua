return {
	{
		"Frestein/gruvbox.nvim",
		opts = {
			overrides = {
				DiagnosticSignOk = { link = "GruvboxGreen" },
				DiagnosticSignWarn = { link = "GruvboxYellow" },
				DiagnosticSignError = { link = "GruvboxRed" },
				DiagnosticSignInfo = { link = "GruvboxBlue" },
				DiagnosticSignHint = { link = "GruvboxAqua" },
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
				--- blink.cmp ---
				BlinkCmpKindSupermaven = { link = "GruvboxYellow" },
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

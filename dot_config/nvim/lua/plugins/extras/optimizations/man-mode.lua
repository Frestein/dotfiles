local function is_man_mode()
	for _, arg in pairs(vim.v.argv) do
		if arg == "+Man!" then
			return true
		end
	end
	return false
end

local function is_not_man_mode()
	return not is_man_mode()
end

return {
	{ "akinsho/bufferline.nvim", optional = true, cond = is_not_man_mode },
	{ "andrewferrier/debugprint.nvim", optional = true, cond = is_not_man_mode },
	{ "echasnovski/mini.ai", optional = true, cond = is_not_man_mode },
	{ "echasnovski/mini.align", optional = true, cond = is_not_man_mode },
	{ "echasnovski/mini.files", optional = true, cond = is_not_man_mode },
	{ "echasnovski/mini.move", optional = true, cond = is_not_man_mode },
	{ "echasnovski/mini.operators", optional = true, cond = is_not_man_mode },
	{ "echasnovski/mini.pairs", optional = true, cond = is_not_man_mode },
	{ "echasnovski/mini.surround", optional = true, cond = is_not_man_mode },
	{ "folke/todo-comments.nvim", optional = true, cond = is_not_man_mode },
	{ "folke/trouble.nvim", optional = true, cond = is_not_man_mode },
	{ "folke/ts-comments.nvim", optional = true, cond = is_not_man_mode },
	{ "folke/which-key.nvim", optional = true, cond = is_not_man_mode },
	{ "hiphish/rainbow-delimiters.nvim", optional = true, cond = is_not_man_mode },
	{ "nvim-lualine/lualine.nvim", optional = true, cond = is_not_man_mode },
	{ "nvim-treesitter/nvim-treesitter-context", optional = true, cond = is_not_man_mode },
	{ "nvim-treesitter/nvim-treesitter-textobjects", optional = true, cond = is_not_man_mode },
	{ "nvim-zh/colorful-winsep.nvim", optional = true, cond = is_not_man_mode },
	{ "tzachar/highlight-undo.nvim", optional = true, cond = is_not_man_mode },

	{
		"LazyVim/LazyVim",
		opts = function()
			if is_man_mode() then
				vim.o.laststatus = 0
				vim.o.statusline = " "
			end
		end,
	},
}

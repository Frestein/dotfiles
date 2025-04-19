local map = vim.keymap.set

map("n", "<leader>ll", "<cmd>Lazy home<cr>", { desc = "Home" })
map("n", "<leader>lH", "<cmd>Lazy health<cr>", { desc = "Health" })
map("n", "<leader>lL", "<cmd>Lazy log<cr>", { desc = "Log" })
map("n", "<leader>ld", "<cmd>Lazy debug<cr>", { desc = "Debug" })
map("n", "<leader>ls", "<cmd>Lazy sync<cr>", { desc = "Sync" })
map("n", "<leader>lc", "<cmd>Lazy check<cr>", { desc = "Check" })
map("n", "<leader>lp", "<cmd>Lazy profile<cr>", { desc = "Profile" })
map("n", "<leader>lx", "<cmd>LazyExtra<cr>", { desc = "Extra" })

return {
	"folke/which-key.nvim",
	optional = true,
	opts = function(_, opts)
		table.insert(opts.spec, { "<leader>l", group = "lazy" })
	end,
	init = function()
		local wk = require "which-key"
		wk.add {
			{ "<leader>lp", icon = { cat = "filetype", name = "lazy" } },
			{ "<leader>ld", icon = { cat = "filetype", name = "lazy" } },
		}
	end,
}

return {
	{
		"Frestein/supermaven-nvim",
		event = "InsertEnter",
		cmd = {
			"SupermavenUseFree",
			"SupermavenUsePro",
		},
		opts = {
			keymaps = {
				accept_suggestion = nil, -- handled by blink.cmp
			},
			disable_inline_completion = true,
			ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
		},
	},

	{
		"saghen/blink.cmp",
		optional = true,
		dependencies = {
			"huijiro/blink-cmp-supermaven",
		},
		opts = {
			sources = {
				default = { "supermaven" },
				providers = {
					supermaven = {
						kind = "Supermaven",
						module = "blink-cmp-supermaven",
						score_offset = 100,
						async = true,
					},
				},
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		optional = true,
		event = "VeryLazy",
		opts = function(_, opts)
			table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.cmp_source "supermaven")
		end,
	},

	{
		"folke/noice.nvim",
		optional = true,
		opts = function(_, opts)
			vim.list_extend(opts.routes, {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "Starting Supermaven" },
							{ find = "Supermaven Free Tier" },
						},
					},
					skip = true,
				},
			})
		end,
	},
}

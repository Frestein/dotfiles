return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = { "go", "gomod", "gowork", "gotmpl" },
			root = { "go.work", "go.mod" },
		}
	end,

	-- {
	-- 	"ray-x/go.nvim",
	-- 	dependencies = {
	-- 		"neovim/nvim-lspconfig",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	build = ':lua require("go.install").update_all_sync()',
	-- 	event = { "CmdlineEnter" },
	-- 	ft = { "go", "gomod" },
	-- 	opts = {},
	-- },

	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = function()
			vim.lsp.enable "golangci_lint_ls"
		end,
	},

	-- {
	-- 	"mfussenegger/nvim-lint",
	-- 	optional = true,
	-- 	opts = {
	-- 		linters_by_ft = {
	-- 			go = { "golangcilint" },
	-- 			gomod = { "golangcilint" },
	-- 		},
	-- 	},
	-- },

	{
		"saghen/blink.cmp",
		optional = true,
		dependencies = {
			{ "samiulsami/cmp-go-deep", dependencies = { "kkharji/sqlite.lua" } },
			"saghen/blink.compat",
		},
		opts = {
			sources = {
				default = {
					"go_deep",
				},
				providers = {
					go_deep = {
						name = "go_deep",
						module = "blink.compat.source",
						min_keyword_length = 3,
						max_items = 5,
						---@module "cmp_go_deep"
						---@type cmp_go_deep.Options
						opts = {},
					},
				},
			},
		},
	},
}

return {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "jsonc",
		}
	end,

	"stevearc/conform.nvim",
	optional = true,
	cmd = "ConformInfo",
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters = {
			prettier = {
				append_args = function()
					return vim.bo.filetype == "jsonc" and { "--trailing-comma", "none" } or {}
				end,
			},
		},
	},
}

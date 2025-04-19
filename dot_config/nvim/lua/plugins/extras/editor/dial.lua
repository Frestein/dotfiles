return {
	"monaqa/dial.nvim",
	recommended = true,
	optional = true,
	opts = function(_, opts)
		local augend = require "dial.augend"

		opts.dials_by_ft.kotlin = "kotlin"

		opts.groups.default = vim.list_extend(opts.groups.default, {
			augend.constant.new { elements = { "yes", "no" }, word = true, cyclic = true },
			augend.constant.new { elements = { "Yes", "No" }, word = true, cyclic = true },
			augend.constant.new { elements = { "True", "False" }, word = true, cyclic = true },
			augend.constant.new { elements = { "Enable", "Disable" }, word = true, cyclic = true },
			augend.constant.new { elements = { "enable", "disable" }, word = true, cyclic = true },
		})
		opts.groups.lua = vim.list_extend(opts.groups.lua, {
			augend.constant.new { elements = { "==", "~=" }, word = false, cyclic = true },
		})
		opts.groups.kotlin = {
			augend.constant.new { elements = { "val", "var" }, word = true, cyclic = true },
			augend.constant.new {
				elements = { "public", "private", "protected", "internal" },
				word = true,
				cyclic = true,
			},
		}
	end,
}

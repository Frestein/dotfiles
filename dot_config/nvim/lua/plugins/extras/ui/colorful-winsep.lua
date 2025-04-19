local opts = {
	hi = {
		fg = vim.api.nvim_get_hl(0, { name = "NvimSeparator" }).fg,
	},
}

return {
	"nvim-zh/colorful-winsep.nvim",
	event = "WinLeave",
	opts = opts,
}

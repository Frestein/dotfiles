vim.filetype.add {
	extension = {
		asc = "asc",
		gpg = "gpg",
		pgp = "pgp",
	},
}

return {
	"benoror/gpg.nvim",
	ft = { "gpg", "asc", "pgp" },
}

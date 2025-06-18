vim.filetype.add({
	extension = {
		gpg = "gpg",
		asc = "gpg",
	},
})

return {
	"benoror/gpg.nvim",
	ft = { "gpg", "asc", "pgp" },
}

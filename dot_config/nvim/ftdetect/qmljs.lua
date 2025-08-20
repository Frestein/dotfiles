local function augroup(name)
	return vim.api.nvim_create_augroup("nvchan_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"*/quickshell/*.qml",
	},
	group = augroup "qmljs",
	callback = function()
		vim.bo.filetype = "qmljs"
	end,
})

local function augroup(name)
	return vim.api.nvim_create_augroup("nvchan_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"**/*.tmpl",
		"*/.chezmoitemplates/**",
	},
	group = augroup "gotmpl",
	callback = function()
		if vim.fn.search("{{.\\+}}", "nw") > 0 then
			vim.bo.filetype = "gotmpl"
		end
	end,
})

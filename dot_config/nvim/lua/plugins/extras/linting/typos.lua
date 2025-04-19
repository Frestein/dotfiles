local function get_filetypes(command)
	local filetypes = {}
	local handle = io.popen(command)

	if not handle then
		return filetypes
	end

	local result = handle:read "*a"
	handle:close()

	for line in result:gmatch "[^\n]+" do
		local filetype = line:match "^(%S+):"
		if filetype then
			table.insert(filetypes, filetype)
		end
	end

	return filetypes
end

return {
	"neovim/nvim-lspconfig",
	optional = true,
	---@class PluginLspOpts
	opts = {
		---@type lspconfig.options
		servers = {
			typos_lsp = {
				init_options = {
					diagnosticSeverity = "Info",
				},
				filetypes = get_filetypes "typos --type-list",
			},
		},
	},
}

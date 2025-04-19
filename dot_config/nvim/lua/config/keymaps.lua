local map = vim.keymap.set
local unmap = vim.keymap.del

local function unmap_defaults(config)
	local extras = {
		["plugins.extras.keys.lazy-extended"] = {
			{ mode = "n", key = "<leader>l" },
		},
		["plugins.extras.keys.bufferline.focus-left-or-right"] = {
			{ mode = "n", key = "<S-h>" },
			{ mode = "n", key = "<S-l>" },
		},
	}

	if config.data and config.data.extras then
		for extra, mappings in pairs(extras) do
			if vim.tbl_contains(config.data.extras, extra) then
				for _, mapping in ipairs(mappings) do
					pcall(unmap, mapping.mode, mapping.key)
				end
			end
		end
	end
end

unmap_defaults(LazyVim.config.json)

-- Terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Escape Terminal Mode" })

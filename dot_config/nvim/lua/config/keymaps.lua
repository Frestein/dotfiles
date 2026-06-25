local map = vim.keymap.set
local unmap = vim.keymap.del

-- Fix H & L keymaps (langmapper issue)
map("n", "H", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "L", "<cmd>bnext<cr>", { desc = "Next Buffer" })

local function unmap_defaults(config)
	local extras = {
		["plugins.extras.keys.lazy-extended"] = {
			{ mode = "n", key = "<leader>l" },
		},
		["plugins.extras.keys.bufferline.focus-left-or-right"] = {
			{ mode = "n", key = "H" },
			{ mode = "n", key = "L" },
		},
		["plugins.extras.util.magit"] = {
			{ mode = "n", key = "<leader>gG" },
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

map("n", "<leader>fs", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Escape Terminal Mode" })

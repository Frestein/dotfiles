local fs = require "utils.fs"

local plugins = {
	recommended = function()
		return LazyVim.extras.wants {
			ft = "lua",
			root = {
				".luarc.json",
				"stylua.toml",
				"selene.toml",
			},
		}
	end,

	"mfussenegger/nvim-lint",
	optional = true,
	opts = {
		linters_by_ft = {
			lua = { "selene" },
		},
		---@type table<string, table>
		linters = {
			selene = {
				condition = function(ctx)
					return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
				end,
			},
		},
	},
}

---@param plugin LazyPluginSpec
local function add_plugin(plugin)
	table.insert(plugins, plugin)
end

if fs.exists "mpv" then
	add_plugin {
		"Frestein/mpv-types-lua",
		name = "mpv-types",
	}

	add_plugin {
		"folke/lazydev.nvim",
		optional = true,
		opts = function(_, opts)
			if vim.fn.expand("%:p"):match "mpv" then
				table.insert(opts.library, { path = "mpv-types/types", words = { "mp" } })
			end
		end,
	}
end

return plugins

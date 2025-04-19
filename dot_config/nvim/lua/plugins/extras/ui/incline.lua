return {
	"b0o/incline.nvim",
	event = "VeryLazy",
	config = function()
		local devicons = require "nvim-web-devicons"
		local incline = require "incline"

		local modules = {
			render = function(props)
				local function get_git_diff()
					local icons = { added = "", changed = "", removed = "" }
					local signs = vim.b[props.buf].gitsigns_status_dict
					local labels = {}

					if signs == nil then
						return labels
					end

					local order = { "added", "changed", "removed" }

					for _, name in ipairs(order) do
						if tonumber(signs[name]) and signs[name] > 0 then
							table.insert(labels, { icons[name] .. " " .. signs[name] .. " ", group = "Diff" .. name })
						end
					end

					if #labels > 0 then
						table.insert(labels, { "| " })
					end

					return labels
				end

				local function get_diagnostic_label()
					local icons = { error = "󰅙", warn = "", hint = "󰛩", info = "󰋼" }
					local labels = {}

					local order = { "error", "warn", "hint", "info" }

					for _, severity in ipairs(order) do
						local n = #vim.diagnostic.get(
							props.buf,
							{ severity = vim.diagnostic.severity[string.upper(severity)] }
						)
						if n > 0 then
							table.insert(
								labels,
								{ icons[severity] .. " " .. n .. " ", group = "DiagnosticSign" .. severity }
							)
						end
					end

					if #labels > 0 then
						table.insert(labels, { "| " })
					end

					return labels
				end

				local function get_file_info(buf)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[buf].modified

					local components = {}

					if ft_icon then
						table.insert(components, { ft_icon, " ", guibg = "none", guifg = ft_color })
					end

					table.insert(components, { filename, gui = modified and "bold,italic" or "bold" })

					return components
				end

				return {
					{ get_git_diff() },
					{ get_diagnostic_label() },
					{ get_file_info(props.buf) },
				}
			end,
		}

		incline.setup(modules)
	end,
}

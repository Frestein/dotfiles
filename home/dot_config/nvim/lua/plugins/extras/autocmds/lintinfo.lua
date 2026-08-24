return {
	"mfussenegger/nvim-lint",
	optional = true,
	init = function()
		-- Show linters for the current buffer's file type
		vim.api.nvim_create_user_command("LintInfo", function()
			local filetype = vim.bo.filetype
			local linters = require("lint").linters_by_ft[filetype]

			if linters then
				Snacks.notify.info(
					"Linters for " .. filetype .. ": " .. table.concat(linters, ", "),
					{ title = "nvim-lint" }
				)
			else
				Snacks.notify.warn("No linters configured for filetype: " .. filetype, { title = "nvim-lint" })
			end
		end, {})
	end,
}

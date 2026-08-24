local M = {}

local utils = require "utils.web"

function M.get_diagnostics(range_start, range_end)
	if range_end == nil then
		range_end = range_start
	end

	local bufnr = vim.api.nvim_get_current_buf()
	local diagnostics = {}

	for line_num = range_start, range_end do
		local line_diagnostics = vim.diagnostic.get(bufnr, {
			lnum = line_num - 1,
			severity = { min = vim.diagnostic.severity.HINT },
		})
		if next(line_diagnostics) ~= nil then
			for _, diagnostic in ipairs(line_diagnostics) do
				table.insert(diagnostics, {
					line_number = line_num,
					message = diagnostic.message,
					severity = utils.to_title_case(vim.diagnostic.severity[diagnostic.severity]),
				})
			end
		end
	end

	return diagnostics
end

function M.get_open_command()
	local open
	if vim.fn.has "win32" == 1 then
		open = 'cmd /c start ""'
	elseif vim.fn.has "macunix" == 1 then
		open = "open"
	else
		open = "xdg-open"
	end
	return open
end

M.open_search_url = function(search_engine, programming_language, severity, message)
	local search_string = programming_language .. " " .. severity .. " " .. message

	local search_url = search_engine .. search_string

	local open_command = M.get_open_command()

	local command = open_command .. " " .. '"' .. search_url .. '"'

	-- Open the URL using the appropriate command
	vim.fn.system(command)
end

M.search = function()
	local line = vim.fn.line "."
	local diagnostics = M.get_diagnostics(line)
	local selected_search_engine = "https://4get.ducks.party/web?s="

	if selected_search_engine == nil then
		local message = "Invalid search engine"
		vim.notify(message, vim.log.levels.WARN)
		return message
	end

	if next(diagnostics) == nil then
		local message = "No diagnostics found!"
		vim.notify(message, vim.log.levels.WARN)
		return message
	end

	local programming_language = utils.get_programming_language()

	-- Let user select a diagnostic to search if multiple are present
	if #diagnostics > 1 then
		local opts = {
			prompt = "Choose a diagnostic:",
			format_item = function(item)
				return utils.rm_file_paths(item.message)
			end,
		}
		vim.ui.select(diagnostics, opts, function(chosen_diagnostic)
			if chosen_diagnostic then
				return M.open_search_url(
					selected_search_engine,
					programming_language,
					chosen_diagnostic.severity,
					chosen_diagnostic.message
				)
			end
		end)
	else
		local diagnostic = diagnostics[1]
		local message = utils.rm_file_paths(diagnostic.message)
		return M.open_search_url(selected_search_engine, programming_language, diagnostic.severity, message)
	end
end

return M

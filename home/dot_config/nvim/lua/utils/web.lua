local M = {}

-- Remove data that is either sensitive or irrelevant to the search
function M.rm_file_paths(inputString)
	local username = vim.fn.system("whoami"):gsub("%s+", "")
	-- Replace the username in the input string with '<user>'
	local path_pattern = "[/\\]Users[/\\]" .. username
	-- Replace the username in the input string only if it follows the /Users/ or \Users\ pattern
	local cleanedString = inputString:gsub(path_pattern, "/Users/<user>")
	return cleanedString
end

function M.get_programming_language()
	local bufnr = vim.api.nvim_get_current_buf()
	local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
	if filetype == "cpp" then
		return "C++"
	else
		return filetype
	end
end

function M.to_title_case(input)
	local output = input:gsub("(%a)([%w_']*)", function(first, rest)
		return first:upper() .. rest:lower()
	end)
	return output
end

return M

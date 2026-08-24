local M = {}

--- Checks if the current directory is a Git repository.
--- @return boolean indicating whether the current directory is a Git repository.
function M.is_git_repo()
	local handle = io.popen "git rev-parse --is-inside-work-tree 2>/dev/null"
	if handle then
		local result = handle:read "*a"
		handle:close()
		return result:match "^true" ~= nil
	end
	return false
end

-- Helper function to parse output
local function parse_output(proc)
	local result = proc:wait()
	local ret = {}
	if result.code == 0 then
		for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
			-- Remove trailing slash
			line = line:gsub("/$", "")
			ret[line] = true
		end
	end
	return ret
end

--- Build git status cache
--- @return table A table that caches ignored and tracked files in the specified Git repository.
function M.new_git_status()
	return setmetatable({}, {
		__index = function(self, key)
			local ignore_proc = vim.system(
				{ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
				{ cwd = key, text = true }
			)
			local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, { cwd = key, text = true })
			local ret = { ignored = parse_output(ignore_proc), tracked = parse_output(tracked_proc) }

			rawset(self, key, ret)
			return ret
		end,
	})
end

return M

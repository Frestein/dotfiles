local function setup()
	local sorting_rules = {
		["Downloads"] = { by = "mtime", reverse = true, dir_first = false },
		["64Gram Desktop"] = { by = "mtime", reverse = true, dir_first = false },
		default = { by = "alphabetical", reverse = false, dir_first = true },
	}

	ps.sub("cd", function()
		local cwd = cx.active.current.cwd

		local rule = sorting_rules.default
		for pattern, config in pairs(sorting_rules) do
			if pattern ~= "default" and cwd:ends_with(pattern) then
				rule = config
				break
			end
		end

		ya.manager_emit("sort", {
			rule.by,
			reverse = rule.reverse,
			dir_first = rule.dir_first,
		})
	end)
end

return { setup = setup }

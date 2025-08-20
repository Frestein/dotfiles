local function is_arch_linux()
	local f = io.open("/etc/os-release", "r")

	if not f then
		return false
	end

	local content = f:read "*all"

	f:close()

	return content:match "ID=arch" ~= nil
end

if is_arch_linux() then
	vim.lsp.config("qmlls", {
		cmd = { "qmlls6" },
	})
end

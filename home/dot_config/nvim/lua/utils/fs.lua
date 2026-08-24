local M = {}

---@type string
M.xdg_config = vim.env.XDG_CONFIG_HOME or (vim.env.HOME .. "/.config")

---@param path string
function M.exists(path)
	return vim.uv.fs_stat(vim.fn.expand("~/" .. path)) ~= nil or vim.uv.fs_stat(M.xdg_config .. "/" .. path) ~= nil
end

return M

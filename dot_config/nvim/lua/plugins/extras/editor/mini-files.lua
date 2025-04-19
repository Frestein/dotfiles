local function create_filter(git_status)
	return function(fs_entry)
		local dir = vim.fs.dirname(fs_entry.path)
		local is_dotfile = vim.startswith(fs_entry.name, ".") and fs_entry.name ~= ".."

		-- if no local directory (e.g. for ssh connections), just hide dotfiles
		if not dir then
			return is_dotfile
		end

		if is_dotfile then
			return git_status[dir].tracked[fs_entry.name]
		else
			return not git_status[dir].ignored[fs_entry.name]
		end
	end
end

local git_status = require("utils.git").new_git_status()

return {
	{
		"echasnovski/mini.files",
		optional = true,
		opts = {
			content = {
				filter = create_filter(git_status),
			},
			options = {
				permanent_delete = false,
			},
			windows = {
				width_preview = 50,
			},
		},
		keys = function()
			local autocmd = vim.api.nvim_create_autocmd
			local map = vim.keymap.set
			local new_git_status = require("utils.git").new_git_status

			local function minifiles_toggle(...)
				if not MiniFiles.close() then
					MiniFiles.open(...)
				end
			end

			-- Set custom marks
			local set_mark = function(id, path, desc)
				MiniFiles.set_bookmark(id, path, { desc })
			end

			-- Mapping to set current working directory
			local set_cwd = function(path)
				-- Works only if cursor is on the valid file system entry
				local entry_path = MiniFiles.get_fs_entry().path
				local cwd = vim.fs.dirname(entry_path)
				vim.fn.chdir(cwd)
			end

			-- Mapping to use grug-far for search in the current directory
			local replace = function(path)
				-- Works only if cursor is on the valid file system entry
				local entry_path = MiniFiles.get_fs_entry().path
				local prefills = { paths = vim.fs.dirname(entry_path) }
				local gf = require "grug-far"

				if not gf.has_instance "explorer" then
					gf.open {
						instanceName = "explorer",
						prefills = prefills,
						staticTitle = "Find and Replace from Explorer",
					}
				else
					gf.open_instance "explorer"
					-- Updating the prefills without crealing the search and other fields
					gf.update_instance_prefills("explorer", prefills, false)
				end
			end

			-- Mapping to show/hide dot-files and git ignored files
			local git_status = new_git_status()

			local show_hidden = false

			local filter_show = function(fs_entry)
				return true
			end

			local filter_hide = create_filter

			local toggle_dotfiles = function()
				show_hidden = not show_hidden
				local new_filter = show_hidden and filter_show or filter_hide(git_status)
				MiniFiles.refresh { content = { filter = new_filter } }
			end

			-- Mapping to show/hide preview window
			local show_preview = false

			local toggle_preview = function()
				show_preview = not show_preview
				MiniFiles.refresh { windows = { preview = show_preview } }
			end

			-- Mappings to modify target window via new tab
			local map_tab = function(buf_id, l)
				local function r()
					local fs_entry = MiniFiles.get_fs_entry()

					if fs_entry then
						MiniFiles.close()
						vim.cmd("tabnew " .. fs_entry.path)
					end
				end

				map("n", l, r, { buffer = buf_id, desc = "Open in new tab" })
			end

			-- Mappings to modify target window via split
			local map_split = function(buf_id, l, direction)
				local function r()
					-- Make new window and set it as target
					local cur_target = MiniFiles.get_explorer_state().target_window

					local new_target = vim.api.nvim_win_call(cur_target, function()
						vim.cmd(direction .. " split")
						return vim.api.nvim_get_current_win()
					end)

					MiniFiles.set_target_window(new_target)
				end

				-- Adding `desc` will result into `show_help` entries
				map("n", l, r, { buffer = buf_id, desc = "Split " .. direction })
			end

			autocmd("User", {
				pattern = "MiniFilesExplorerOpen",
				callback = function()
					set_mark("c", vim.fn.stdpath "config", "Config") -- path
					set_mark("w", vim.fn.getcwd, "Working directory") -- callable
					set_mark("~", "~", "Home directory")
				end,
			})

			autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					map("n", "g~", set_cwd, { buffer = args.data.buf_id, desc = "Set cwd" })
					map("n", "gs", replace, { buffer = args.data.buf_id, desc = "Search in directory" })
					map("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden" })
					map("n", "<C-p>", toggle_preview, { buffer = buf_id, desc = "Toggle preview" })
					map_tab(buf_id, "<C-t>")
					map_split(buf_id, "<C-s>", "belowright horizontal")
					map_split(buf_id, "<C-v>", "belowright vertical")
				end,
			})

			autocmd("User", {
				pattern = "MiniFilesActionRename",
				callback = function(event)
					Snacks.rename.on_rename_file(event.data.from, event.data.to)
				end,
			})

			return {
				{
					"<leader>e",
					function()
						minifiles_toggle(vim.api.nvim_buf_get_name(0))
					end,
					desc = "Toggle Current Directory",
				},
				{
					"<leader>E",
					function()
						minifiles_toggle()
					end,
					desc = "Toggle Root Directory",
				},
			}
		end,
	},

	{
		"folke/lazydev.nvim",
		optional = true,
		opts = {
			library = {
				{ path = "mini.fles", words = { "MiniFiles" } },
			},
		},
	},
}

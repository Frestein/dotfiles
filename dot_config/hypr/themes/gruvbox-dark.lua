local paths = require "lib.paths"

local M = {}

-- ###################
-- Colorscheme
-- ###################

M.regular_0 = "rgb(282828)" -- black
M.regular_1 = "rgb(cc241d)" -- red
M.regular_2 = "rgb(98971a)" -- green
M.regular_3 = "rgb(d79921)" -- yellow
M.regular_4 = "rgb(458588)" -- blue
M.regular_5 = "rgb(b16286)" -- magenta
M.regular_6 = "rgb(689d6a)" -- cyan
M.regular_7 = "rgb(a89984)" -- white

M.bright_0 = "rgb(928374)" -- bright black
M.bright_1 = "rgb(fb4934)" -- bright red
M.bright_2 = "rgb(b8bb26)" -- bright green
M.bright_3 = "rgb(fabd2f)" -- bright yellow
M.bright_4 = "rgb(83a598)" -- bright blue
M.bright_5 = "rgb(d3869b)" -- bright magenta
M.bright_6 = "rgb(8ec07c)" -- bright cyan
M.bright_7 = "rgb(ebdbb2)" -- bright white

M.orange_0 = "rgb(d65d0e)"
M.orange_1 = "rgb(fe8019)"

-- ####################
-- Alpha colors
-- ####################

M.regular_alpha_0 = "282828" -- black
M.regular_alpha_1 = "cc241d" -- red
M.regular_alpha_2 = "98971a" -- green
M.regular_alpha_3 = "d79921" -- yellow
M.regular_alpha_4 = "458588" -- blue
M.regular_alpha_5 = "b16286" -- magenta
M.regular_alpha_6 = "689d6a" -- cyan
M.regular_alpha_7 = "a89984" -- white

M.bright_alpha_0 = "928374" -- bright black
M.bright_alpha_1 = "fb4934" -- bright red
M.bright_alpha_2 = "b8bb26" -- bright green
M.bright_alpha_3 = "fabd2f" -- bright yellow
M.bright_alpha_4 = "83a598" -- bright blue
M.bright_alpha_5 = "d3869b" -- bright magenta
M.bright_alpha_6 = "8ec07c" -- bright cyan
M.bright_alpha_7 = "ebdbb2" -- bright white

-- #################
-- UI colors
-- #################

M.black = M.regular_0
M.red = M.regular_1
M.green = M.regular_2
M.yellow = M.regular_3
M.blue = M.regular_4
M.magenta = M.regular_5
M.cyan = M.regular_6
M.white = M.regular_7

M.bright_black = M.bright_0
M.bright_red = M.bright_1
M.bright_green = M.bright_2
M.bright_yellow = M.bright_3
M.bright_blue = M.bright_4
M.bright_magenta = M.bright_5
M.bright_cyan = M.bright_6
M.bright_white = M.bright_7

M.background = M.regular_0
M.background_image = paths.wallpapers_path .. "/hyprlock/gruvbox_a_city_skyline_with_many_tall_buildings_01.png"

M.accent = M.bright_2
M.accent_alpha = M.bright_alpha_2

M.text = M.bright_7
M.text_alpha = M.bright_alpha_7

M.surface_0 = "rgb(3c3836)"

M.active_border = M.bright_0
M.inactive_border = M.regular_0

M.group_active_border = M.bright_0
M.group_inactive_border = M.regular_0
M.group_locked_active_border = M.bright_0
M.group_locked_inactive_border = M.regular_0

M.group_bar_active_border = M.regular_2
M.group_bar_inactive_border = M.regular_0
M.group_bar_locked_active_border = M.orange_0
M.group_bar_locked_inactive_border = M.regular_0

return M

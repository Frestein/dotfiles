local paths = require("lib.paths")

local M = {}

-- ###################
-- Colorscheme
-- ###################

M.regular0 = "rgb(282828)" -- black
M.regular1 = "rgb(cc241d)" -- red
M.regular2 = "rgb(98971a)" -- green
M.regular3 = "rgb(d79921)" -- yellow
M.regular4 = "rgb(458588)" -- blue
M.regular5 = "rgb(b16286)" -- magenta
M.regular6 = "rgb(689d6a)" -- cyan
M.regular7 = "rgb(a89984)" -- white

M.bright0 = "rgb(928374)" -- bright black
M.bright1 = "rgb(fb4934)" -- bright red
M.bright2 = "rgb(b8bb26)" -- bright green
M.bright3 = "rgb(fabd2f)" -- bright yellow
M.bright4 = "rgb(83a598)" -- bright blue
M.bright5 = "rgb(d3869b)" -- bright magenta
M.bright6 = "rgb(8ec07c)" -- bright cyan
M.bright7 = "rgb(ebdbb2)" -- bright white

M.orange0 = "rgb(d65d0e)"
M.orange1 = "rgb(fe8019)"

-- ####################
-- Alpha colors
-- ####################

M.regularAlpha0 = "282828" -- black
M.regularAlpha1 = "cc241d" -- red
M.regularAlpha2 = "98971a" -- green
M.regularAlpha3 = "d79921" -- yellow
M.regularAlpha4 = "458588" -- blue
M.regularAlpha5 = "b16286" -- magenta
M.regularAlpha6 = "689d6a" -- cyan
M.regularAlpha7 = "a89984" -- white

M.brightAlpha0 = "928374" -- bright black
M.brightAlpha1 = "fb4934" -- bright red
M.brightAlpha2 = "b8bb26" -- bright green
M.brightAlpha3 = "fabd2f" -- bright yellow
M.brightAlpha4 = "83a598" -- bright blue
M.brightAlpha5 = "d3869b" -- bright magenta
M.brightAlpha6 = "8ec07c" -- bright cyan
M.brightAlpha7 = "ebdbb2" -- bright white

-- #################
-- UI colors
-- #################

M.black = M.regular0
M.red = M.regular1
M.green = M.regular2
M.yellow = M.regular3
M.blue = M.regular4
M.magenta = M.regular5
M.cyan = M.regular6
M.white = M.regular7

M.brightBlack = M.bright0
M.brightRed = M.bright1
M.brightGreen = M.bright2
M.brightYellow = M.bright3
M.brightBlue = M.bright4
M.brightMagenta = M.bright5
M.brightCyan = M.bright6
M.brightWhite = M.bright7

M.background = M.regular0
M.backgroundImage = paths.wallpapers_path .. "/hyprlock/gruvbox_a_city_skyline_with_many_tall_buildings_01.png"

M.accent = M.bright2
M.accentAlpha = M.brightAlpha2

M.text = M.bright7
M.textAlpha = M.brightAlpha7

M.surface0 = "rgb(3c3836)"

M.activeBorder = M.bright0
M.inactiveBorder = M.regular0

M.groupActiveBorder = M.bright0
M.groupInactiveBorder = M.regular0
M.groupLockedActiveBorder = M.bright0
M.groupLockedInactiveBorder = M.regular0

M.groupBarActiveBorder = M.regular2
M.groupBarInactiveBorder = M.regular0
M.groupBarLockedActiveBorder = M.orange0
M.groupBarLockedInactiveBorder = M.regular0

return M

local g = vim.g
local o = vim.o

-- Disable default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

--- LazyVim  ---
g.lazyvim_python_lsp = "basedpyright"

--- UI ---
o.numberwidth = 2
o.pumblend = 15
o.scrolloff = 5
o.signcolumn = "yes"
o.guicursor = table.concat({
	"n-v-c:block",
	"i-ci-ve:ver25",
	"r-cr:hor20",
	"o:hor50",
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
	"sm:block-blinkwait175-blinkoff150-blinkon175",
}, ",")
o.cursorlineopt = "both"
o.fillchars = table.concat({
	"foldopen:",
	"foldclose:",
	"fold: ",
	"foldsep: ", -- or "│" to use bar for show fold area
	"diff:╱",
	"eob: ",
}, ",")

--- Indents, Spaces, Tabulation ---
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

--- Search ---
o.ignorecase = true
o.hlsearch = true
o.infercase = true

--- Folds ---
o.foldlevelstart = 99
o.foldlevel = 99
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldtext = require "modules.foldtext"

--- Swap ---
o.swapfile = false

--- Spell Checking ---
o.spelllang = "en_us,ru_ru"
o.spellfile = os.getenv "XDG_CONFIG_HOME" .. "/nvim/spell/en.utf-8.add"

--- Langmapper ---
local function escape(str)
	local escape_chars = [[;,."|\]]
	return vim.fn.escape(str, escape_chars)
end

local en = [[qwertyuiop[]asdfghjkl;zxcvbnm,.]]
local ru = [[йцукенгшщзхъфывапролджячсмитьбю]]
local en_shift = [[QWERTYUIOP{}ASDFGHJKL:ZXCVBNM<>]]
local ru_shift = [[ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЯЧСМИТЬБЮ]]

o.langmap = vim.fn.join({
	escape(ru_shift) .. ";" .. escape(en_shift),
	escape(ru) .. ";" .. escape(en),
}, ",")

--- Other ---
o.wrap = true
-- Disable nvim intro
o.shortmess = o.shortmess .. "sI"
-- Go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
o.whichwrap = o.whichwrap .. "<,>,[,],h,l"

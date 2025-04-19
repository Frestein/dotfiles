-- bootstrap lazy.nvim, LazyVim and your plugins
require "config.lazy"

require "config.compat"

-- Load modules
require("modules.improve-visual-block").setup()
require "modules.punto-switcher"

-- Automap keybindings
require("langmapper").automapping { global = true, buffer = false }

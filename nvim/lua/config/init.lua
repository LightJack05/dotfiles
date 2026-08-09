-- Load order for the nvim config. Plugins themselves are installed by nix
-- (see nvim/nvim.nix) — there is no plugin manager and no runtime fetching.

-- ===================
-- Core editor settings and keymaps
-- ===================
require("config.editor")
require("config.keymap")

-- ===================
-- UI plugins
-- ===================
require("config.theme")
require("config.lualine")
require("config.nvim-tree")
require("config.undotree")

-- ===================
-- Coding aids
-- ===================
require("config.telescope")
require("config.neogen")
require("config.indent-blankline")
require("config.indent-scope")
require("config.signatureHelp")

-- ===================
-- Completion & snippets
-- ===================
require("config.nvim-cmp")
require("config.luasnip")

-- ===================
-- LSP setup
-- ===================
require("config.lsp")

-- ===================
-- Debugging
-- ===================
require("config.dap")

-- Load order for the nvim config. Plugins themselves are installed by nix
-- (see nvim/nvim.nix) — there is no plugin manager and no runtime fetching.
-- LSP servers are likewise configured from nix, via nixvim's `lsp.servers`.

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
require("config.ansible")

-- ===================
-- Completion & snippets
-- ===================
require("config.nvim-cmp")
require("config.luasnip")

-- ===================
-- Debugging
-- ===================
require("config.dap")

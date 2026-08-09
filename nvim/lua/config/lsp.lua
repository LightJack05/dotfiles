-- LTEX
vim.lsp.config("ltex", {
    cmd_env = { JAVA_OPTS = "-Djdk.xml.totalEntitySizeLimit=0" },
    settings = { ltex = { language = "en-US" } },
})

-- YAML
vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemaStore = {
          enable = true
      },
    },
  },
})

-- Go, for e2e tests in Kubebuilder
vim.lsp.config("gopls", {
    init_options = {
        semanticTokens = true,
    },
    settings = {
        gopls = {
            buildFlags = { "-tags=e2e" },
            semanticTokens = true
        },
    }
})

-- Nix (lspconfig server name is `nil_ls`). Format with `nixfmt` from PATH
-- (installed globally via home.packages; see nvim/nvim.nix).
vim.lsp.config("nil_ls", {
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
})

-- Enable LSP servers, but only those whose binary is actually available on
-- PATH — i.e. provided globally or by the dev shell nvim was launched in.
-- The command is read from nvim-lspconfig's own config, so no server names or
-- binary names need to be hardcoded here. Open a Go file inside a shell that
-- provides `gopls` and it attaches; elsewhere it stays quiet.
local servers = {
    "ansiblels", "pyright", "bashls", "biome", "cssls", "jsonls", "ts_ls",
    "yamlls", "clangd", "omnisharp", "gopls", "ltex", "texlab", "lua_ls",
    "rust_analyzer", "nil_ls",
}

for _, name in ipairs(servers) do
    local ok, cfg = pcall(function() return vim.lsp.config[name] end)
    local cmd = (ok and cfg) and cfg.cmd or nil
    local exe = type(cmd) == "table" and cmd[1] or nil
    if exe and vim.fn.executable(exe) == 1 then
        vim.lsp.enable(name)
    end
end

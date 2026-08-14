{ pkgs, lib, ... }:

let
  # LSP servers, configured through nixvim's native `lsp.servers` module (which
  # wraps neovim's builtin `vim.lsp.config` / `vim.lsp.enable` API).
  #
  # The value of each entry is the server's `vim.lsp.config` table; an empty set
  # means nvim-lspconfig's shipped defaults are enough. No server is installed
  # by nixvim itself (`package = null` below) — the binary is looked up on PATH,
  # so a server is only activated when it is provided globally (see
  # `home.packages`) or by the dev shell nvim was launched in.
  lspServers = {
    # Ansible. Attaches to the `yaml.ansible` filetype only, which neovim does
    # not set on its own — lua/config/ansible.lua handles that detection.
    # Roles are frequently edited standalone, without an `ansible.cfg` or
    # `.ansible-lint` anywhere above them, so fall back to the repo root; the
    # nested lists express priority (closest ansible marker beats `.git`).
    ansiblels.root_markers = [
      [
        "ansible.cfg"
        ".ansible-lint"
        "galaxy.yml"
      ]
      [ ".git" ]
    ];

    bashls = { };
    biome = { };
    clangd = { };
    cssls = { };
    jsonls = { };
    lua_ls = { };
    omnisharp = { };
    pyright = { };
    rust_analyzer = { };
    texlab = { };
    ts_ls = { };

    # LTEX
    ltex = {
      cmd_env.JAVA_OPTS = "-Djdk.xml.totalEntitySizeLimit=0";
      settings.ltex.language = "en-US";
    };

    # YAML
    yamlls.settings.yaml.schemaStore.enable = true;

    # Go, for e2e tests in Kubebuilder
    gopls = {
      init_options.semanticTokens = true;
      settings.gopls = {
        buildFlags = [ "-tags=e2e" ];
        semanticTokens = true;
      };
    };

    # Nix (lspconfig server name is `nil_ls`). Format with `nixfmt` from PATH
    # (installed globally via home.packages, below).
    nil_ls.settings."nil".formatting.command = [ "nixfmt" ];
  };

  # The same server names as a Lua list literal, for the activation guard below.
  lspServerNamesLua = "{ ${lib.concatMapStringsSep ", " (n: ''"${n}"'') (builtins.attrNames lspServers)} }";
in

{
  programs.nixvim = {
    enable = true;

    # Reuse home-manager's own nixpkgs instance instead of letting nixvim build
    # a second one from its pinned source. Keeps a single, consistent nixpkgs
    # and silences nixvim's "inputs pin Nixpkgs to ..." follows warning.
    nixpkgs.pkgs = pkgs;

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    # Plugins
    extraPlugins = with pkgs.vimPlugins; [
      # Fuzzy finder
      telescope-nvim
      plenary-nvim

      # Editing / UI
      undotree
      nvim-tree-lua
      nvim-web-devicons
      lualine-nvim
      indent-blankline-nvim
      mini-nvim # provides mini.indentscope
      neogen

      # Completion + snippets
      nvim-cmp
      cmp-nvim-lsp
      cmp_luasnip
      luasnip
      friendly-snippets

      # Debugging
      nvim-dap
      nvim-dap-ui
      nvim-nio
    ];

    # nvim-lspconfig is installed purely for the *default* configs it ships for
    # `vim.lsp.config` (cmd, filetypes, root markers). It performs no setup of
    # its own; enabling and configuring servers happens via `lsp.servers` below.
    plugins.lspconfig.enable = true;

    lsp.servers = lib.mapAttrs (_: serverConfig: {
      enable = true;
      package = null; # resolve the binary from PATH, don't pull it into the closure
      activate = false; # `vim.lsp.enable()` is called by the guard below instead
      config = serverConfig;
    }) lspServers;

    # Activate LSP servers, but only those whose binary is actually available on
    # PATH — i.e. provided globally or by the dev shell nvim was launched in.
    # The command is read from nvim-lspconfig's own config, so no binary names
    # need to be hardcoded here. Open a Go file inside a shell that provides
    # `gopls` and it attaches; elsewhere it stays quiet.
    lsp.luaConfig.post = ''
      for _, name in ipairs(${lspServerNamesLua}) do
        local ok, cfg = pcall(function() return vim.lsp.config[name] end)
        local cmd = (ok and cfg) and cfg.cmd or nil
        local exe = type(cmd) == "table" and cmd[1] or nil
        if exe and vim.fn.executable(exe) == 1 then
          vim.lsp.enable(name)
        end
      end
    '';

    extraFiles = {
      "lua/config/init.lua".source = ./lua/config/init.lua;
      "lua/config/editor.lua".source = ./lua/config/editor.lua;
      "lua/config/keymap.lua".source = ./lua/config/keymap.lua;
      "lua/config/theme.lua".source = ./lua/config/theme.lua;
      "lua/config/lualine.lua".source = ./lua/config/lualine.lua;
      "lua/config/nvim-tree.lua".source = ./lua/config/nvim-tree.lua;
      "lua/config/undotree.lua".source = ./lua/config/undotree.lua;
      "lua/config/telescope.lua".source = ./lua/config/telescope.lua;
      "lua/config/neogen.lua".source = ./lua/config/neogen.lua;
      "lua/config/indent-blankline.lua".source = ./lua/config/indent-blankline.lua;
      "lua/config/indent-scope.lua".source = ./lua/config/indent-scope.lua;
      "lua/config/signatureHelp.lua".source = ./lua/config/signatureHelp.lua;
      "lua/config/ansible.lua".source = ./lua/config/ansible.lua;
      "lua/config/nvim-cmp.lua".source = ./lua/config/nvim-cmp.lua;
      "lua/config/luasnip.lua".source = ./lua/config/luasnip.lua;
      "lua/config/dap.lua".source = ./lua/config/dap.lua;
    };

    extraConfigLua = ''
      require("config")
    '';
  };

  # Global LSPs
  home.packages = with pkgs; [
    ripgrep # for telescope
    nil
    nixfmt # nix formatter (`nixfmt`); nixfmt-rfc-style is now an alias for this
    lua-language-server
    bash-language-server
  ];
}

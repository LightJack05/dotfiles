{ pkgs, ... }:

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

      # LSP
      nvim-lspconfig

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
      "lua/config/nvim-cmp.lua".source = ./lua/config/nvim-cmp.lua;
      "lua/config/luasnip.lua".source = ./lua/config/luasnip.lua;
      "lua/config/lsp.lua".source = ./lua/config/lsp.lua;
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

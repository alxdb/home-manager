{ config, pkgs, ... }:
let
  helpers = config.lib.nixvim;
in
{
  programs.nixvim =
    { lib, ... }:
    {
      enable = true;

      # Command settings
      defaultEditor = true;
      vimdiffAlias = true;
      viAlias = true;
      vimAlias = true;

      # Colorscheme
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
        };
      };

      # Options & Globals
      plugins.sleuth.enable = true; # Only related to tabstop options
      globals = {
        mapleader = " ";
      };
      opts = {
        number = true;
        signcolumn = "number";
        # Default indentation (overridden by sleuth)
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        # Global statusbar
        laststatus = 3;
        # Evaluate exrc files
        exrc = true;
        # Folding options
        foldlevel = 2;
      };

      # Autocmds
      autoCmd = [
          event = "QuickFixCmdPost";
          callback = helpers.mkRaw ''
            function()
              local qflist = vim.fn.getqflist()
              local ns = vim.api.nvim_create_namespace("quickfix")
              local buf_diagnostics = {}
              
              for _, item in ipairs(qflist) do
                local bufnr = item.bufnr
                if bufnr > 0 then
                  if not buf_diagnostics[bufnr] then
                    buf_diagnostics[bufnr] = {}
                  end
                  table.insert(buf_diagnostics[bufnr], {
                    lnum = item.lnum - 1,
                    col = item.col - 1,
                    message = item.text,
                    severity = vim.diagnostic.severity.ERROR,
                  })
                end
              end
              
              for bufnr, diags in pairs(buf_diagnostics) do
                vim.diagnostic.set(ns, bufnr, diags)
              end
            end
          ''
        }
      ];

      # Treesitter
      plugins.treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
      };

      # Which Key
      plugins.which-key.enable = true;

      # Lualine
      plugins.lualine.enable = true;
    };
  xdg.configFile."nvim/after/queries/cpp/highlights.scm".text = ''
    ; extends

    [
      "import"
      "export"
      "module"
    ] @keyword
  '';
}

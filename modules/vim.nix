{ pkgs, ... }:
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
      globals = {
        mapleader = " ";
      };

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

      # Options
      plugins.sleuth.enable = true; # Only related to tabstop options
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

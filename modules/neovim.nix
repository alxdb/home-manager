{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = [
      # Treesitter deps 
      pkgs.tree-sitter
      pkgs.gcc
      pkgs.nodejs
      # Telescope deps
      pkgs.ripgrep
      pkgs.fd
      # Language Tools
      ## nix
      pkgs.nixfmt-rfc-style
      pkgs.nil
      ## lua
      pkgs.stylua
      pkgs.lua-language-server
      ## json,yaml,toml,md,etc...
      pkgs.vscode-langservers-extracted
      pkgs.yaml-language-server
      pkgs.prettierd
      pkgs.taplo
      ## css,html,js,ts,etc...
      pkgs.tailwindcss-language-server
      pkgs.nodePackages.typescript-language-server
      ## go
      pkgs.gopls
      ## protobuf
      pkgs.buf-language-server
      pkgs.buf
      ## purescript
      pkgs.nodePackages.purescript-language-server
      pkgs.nodePackages.purs-tidy
      pkgs.dhall-lsp-server
      ## rust
      pkgs.rust-analyzer
      pkgs.rustc
      pkgs.rustfmt
      ## haskell
      pkgs.haskell-language-server
      pkgs.haskellPackages.cabal-fmt
      ## elixir
      pkgs.elixir-ls
      ## C++
      pkgs.clang-tools_18
    ];
  };
  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };
}

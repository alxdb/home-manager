{ pkgs, lib, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alxdb";
  home.homeDirectory = "/home/alxdb";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [ htop ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'.
  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Catppuccin flavour 
  catppuccin.flavour = "mocha";
  catppuccin.accent = "lavender";

  # Shell configuration
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = "$terminfo[kcuu1]";
      searchDownKey = "$terminfo[kcud1]";
    };

    defaultKeymap = "viins";

    shellAliases = {
      g = "git";
      lg = "lazygit";
      vf = ''
        vi +':lua require("telescope.builtin").fd()'
      '';
    };

    # loginExtra = ''
    #   if [[ $(tty) = /dev/tty1 ]]; then
    #     exec sway
    #   fi
    # '';
  };
  programs.starship = {
    enable = true;
    catppuccin.enable = true;
    settings = (import ./starship.nix);
  };
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd"
      "cd"
    ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.lsd = {
    enable = true;
    enableAliases = true;
  };
  programs.bat = {
    enable = true;
    catppuccin.enable = true;
  };

  # Editor configuration
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
      pkgs.dhall-lsp-server
      ## rust
      pkgs.rust-analyzer
      pkgs.rustc
      pkgs.rustfmt
    ];
  };
  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  # VCS configuration
  programs.git = {
    enable = true;
    userName = "Alexander Davidson Bryan";
    userEmail = "alxdb@pm.me";
    aliases = {
      s = "status";
      c = "commit";
      ca = "commit -a";
      b = "checkout -b";
      d = "difftool";
      p = "push";
    };
    extraConfig = {
      init.defaultBranch = "main";
      diff.tool = "nvimdiff";
    };
    ignores = [
      ".envrc"
      ".direnv"
      "result"
    ];
  };
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
  programs.ssh.enable = true;
  services.ssh-agent.enable = true;
  programs.lazygit = {
    enable = true;
    catppuccin.enable = true;
  };

  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}

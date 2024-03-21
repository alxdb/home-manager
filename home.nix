{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'.
  home.sessionVariables = {
    # https://github.com/nix-community/home-manager/issues/3711
    LANG = "C.UTF-8";
    GOPATH = "$HOME/.local/go";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Shell configuration
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    defaultKeymap = "viins";

    shellAliases = { g = "git"; };
  };
  programs.starship.enable = true;
  home.file."./.config/starship.toml" = { source = ./starship.toml; };
  programs.zoxide = {
    enable = true;
    options = [ "--cmd" "cd" ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.lsd = {
    enable = true;
    enableAliases = true;
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
      pkgs.nixfmt
      pkgs.nil
      pkgs.stylua
      pkgs.lua-language-server
      pkgs.vscode-langservers-extracted
      pkgs.yaml-language-server
      pkgs.prettierd
      pkgs.taplo
      pkgs.tailwindcss-language-server
      pkgs.nodePackages.typescript-language-server
      pkgs.gopls
      pkgs.buf-language-server
      pkgs.buf
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
    ignores = [ ".envrc" ".direnv" "result" ];
  };
  programs.gh = {
    enable = true;
    settings = { git_protocol = "ssh"; };
  };
  programs.ssh.enable = true;
  services.ssh-agent.enable = true;

  # Tmux 
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    sensibleOnTop = true;
    shortcut = "a";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    reverseSplit = true;
    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"
    '';
    plugins = with pkgs; [ tmuxPlugins.nord tmuxPlugins.prefix-highlight ];
  };
}

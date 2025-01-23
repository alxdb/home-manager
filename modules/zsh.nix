{
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      styles = {
        path_pathseparator = "";
        path_prefix_pathseparator = "";
      };
    };
    historySubstringSearch = {
      enable = true;
      searchUpKey = "$terminfo[kcuu1]";
      searchDownKey = "$terminfo[kcud1]";
    };
    defaultKeymap = "viins";

    shellAliases = {
      gg = "nvim '+Neogit'";
      hm = # sh
        ''(cd ~/.config/home-manager/ && vi flake.nix && home-manager switch) && exec zsh'';
      cat = "bat";
    };
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
    settings = {
      blocks = [
        "permission"
        "user"
        "group"
        "size"
        "date"
        "name"
        "git"
      ];
    };
  };
  programs.bat = {
    enable = true;
  };
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-a";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    reverseSplit = true;
    mouse = true;
    extraConfig = # tmux
      ''
        set -ag terminal-overrides ",*:RGB"
      '';
    catppuccin.extraConfig = # tmux
      ''
        set -g @catppuccin_status_left_separator "█"
        set -g @catppuccin_status_modules_right "session date_time"
      '';
  };
}

{
  username,
  domain,
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
      searchUpKey = if username == "adavidsonbry" then "^[[A" else "$terminfo[kcuu1]";
      searchDownKey = if username == "adavidsonbry" then "^[[B" else "$terminfo[kcud1]";
    };
    defaultKeymap = "viins";

    shellAliases = {
      gg = "nvim '+Neogit'";
      hm = # sh
        ''(cd ~/.config/home-manager/ && vi flake.nix && home-manager switch --flake .#${username}@${domain}) && exec zsh'';
    };
  };
  programs.starship = {
    enable = true;
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

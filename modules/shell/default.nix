{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    (writeShellScriptBin "hm" (builtins.readFile ./hm.sh))
  ];
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
      hm = "~/.nix-profile/bin/hm && exec zsh";
      cat = "bat";
    };

    zplug = {
      enable = true;
      plugins = [
        {
          name = "mafredri/zsh-async";
          tags = [ "from:github" ];
        }
        {
          name = "sindresorhus/pure";
          tags = [
            "from:github"
            "as:theme"
            "use:pure.zsh"
          ];
        }
      ];
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
    extraConfig = ''
      set -ag terminal-overrides ",*:RGB"
    '';
  };
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}

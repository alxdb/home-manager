{ ... }:
{
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
      gl = "lazygit";
      hm = "home-manager";
    };
    initExtra = # bash
      ''
        function vf() {
          vi +":lua require('telescope.builtin').fd { default_text = '$1', file_ignore_patterns = { '.git$', '.git/' }, hidden = true }"
        }
      '';
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
    prefix = "C-a";
  };
}

{ username, pkgs, ... }: {
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  # Base packages (no program entry)
  home.packages = with pkgs; [ htop pipx rustup ];

  # Global colorscheme
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # For python development
  programs.pyenv.enable = true;

  home.stateVersion = "24.05"; # Do not change, even after updating
}

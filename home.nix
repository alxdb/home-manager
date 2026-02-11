{ pkgs, ... }:
rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Specify some required info
  home.username = "alxdb";
  home.homeDirectory = "/home/alxdb";

  # Allow non FOSS programs
  nixpkgs.config.allowUnfree = true;

  # Global packages
  home.packages = with pkgs; [
    htop
    wl-clipboard
    trashy
    # Fonts
    iosevka-comfy.comfy-wide-fixed
    nerd-fonts.symbols-only
    # IDEs
    # jetbrains.idea-community
    # jetbrains.clion
    # ZSA Keyboard
    keymapp
    # For DRM apps
    google-chrome
  ];

  # Global environment
  home.sessionVariables = {
    GOPATH = "${home.homeDirectory}/.go";
    SUDO_EDITOR = "nvim";
  };

  # Catppuccin flavour
  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
    enable = true;
    tmux.extraConfig = ''
      set -g @catppuccin_status_modules_right "session date_time"
      set -g @catppuccin_window_status_style "rounded"
    '';
  };

  # Font configuration
  fonts.fontconfig.enable = true;

  # user-dirs
  xdg.userDirs = {
    enable = true;
    createDirectories = false;
    download = "${home.homeDirectory}/downloads";
    documents = "${home.homeDirectory}/documents";
    desktop = "${home.homeDirectory}/desktop";
    pictures = "${home.homeDirectory}/pictures";
  };

  # You'll need this
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 11;
    };
  };

  # And this
  programs.chromium = {
    package = pkgs.chromium.override { enableWideVine = true; };
    enable = true;
    commandLineArgs = [
      "--ozone-platform-hint=wayland"
      "--force-dark-mode"
    ];
    extensions = [
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # proton pass
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # ublock origin lite
    ];
  };

  # Use an ssh agent
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };
  services.ssh-agent.enable = true;

  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}

{ pkgs, ... }:
rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Specify some required info
  home.username = "alxdb";
  home.homeDirectory = "/home/alxdb";

  # Allow non FOSS programs
  nixpkgs.config.allowUnfree = true;
  # Accept licenses for specific packages
  nixpkgs.config = {
    input-fonts.acceptLicense = true;
  };

  # Global packages
  home.packages = with pkgs; [
    htop
    wl-clipboard
    trashy
    # Fonts
    input-fonts
    jetbrains-mono
    iosevka-comfy.comfy-wide-fixed
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  # Catppuccin flavour 
  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
    enable = true;
  };

  # Font configuration
  fonts.fontconfig = {
    enable = true;
  };

  # user-dirs
  xdg.userDirs = {
    enable = true;
    createDirectories = false;
    download = "${home.homeDirectory}/downloads";
    documents = "${home.homeDirectory}/documents";
    desktop = "${home.homeDirectory}/desktop";
    pictures = "${home.homeDirectory}/pictures";
  };

  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}

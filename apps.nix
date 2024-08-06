{ pkgs, ... }:
{
  home.packages = with pkgs; [ htop ];

  # You'll need this
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Iosevka Comfy Wide Fixed";
      symbol_map = "U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d4,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b1,U+e700-U+e7c5,U+f000-U+f2e0,U+f300-U+f372,U+f400-U+f532,U+f0001-U+f1af0 Symbols Nerd Font Mono";
      wayland_titlebar_color = "background";
      tab_bar_style = "powerline";
      tab_bar_edge = "top";
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
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
    ];
  };

  # Use an ssh agent
  programs.ssh.enable = true;
  services.ssh-agent.enable = true;
}

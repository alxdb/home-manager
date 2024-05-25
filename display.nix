{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard
    protonup
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # Window Manager Configuration + basic apps
  wayland.windowManager = {
    sway = rec {
      enable = true;
      catppuccin.enable = true;
      wrapperFeatures.gtk = true;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        keybindings =
          let
            modifier = config.modifier;
          in
          lib.mkOptionDefault {
            "${modifier}+Alt+Return" = "exec chromium";
            "${modifier}+0" = "workspace number 0";
            "${modifier}+Shift+0" = "move container to workspace number 0";
            "${modifier}+d" = "exec tofi-drun | xargs swaymsg exec --";
            "${modifier}+Shift+d" = "exec tofi-run | xargs swaymsg exec --";
          };
        output = {
          "*" = {
            bg = "$base solid_color";
          };
          "DP-1" = {
            scale = "1.5";
            position = "0 0";
          };
          "DP-2" = {
            transform = "270";
            position = "-1080 0";
          };
        };
        seat = {
          "*" = {
            hide_cursor = "1000";
          };
        };
        window = {
          titlebar = false;
        };
        colors = {
          background = "$base";
          focused = {
            childBorder = "$lavender";
            background = "$base";
            text = "$text";
            indicator = "$mauve";
            border = "$lavender";
          };
          focusedInactive = {
            childBorder = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$lavender";
            border = "$overlay0";
          };
          unfocused = {
            childBorder = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$lavender";
            border = "$overlay0";
          };
          urgent = {
            childBorder = "$peach";
            background = "$base";
            text = "$peach";
            indicator = "$overlay0";
            border = "$peach";
          };
          placeholder = {
            childBorder = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$overlay0";
            border = "$overlay0";
          };
        };
        bars = [ { command = "waybar"; } ];
        gaps = {
          inner = 10;
        };
      };
    };
    hyprland = {
      enable = false;
      catppuccin.enable = true;
      settings = {
        "$mod" = "SUPER";
        bind =
          [ "$mod, Enter, exec, alacritty" ]
          ++ (builtins.concatLists (
            builtins.genList (ws: [
              "$mod, ${toString ws}, workspace, ${toString ws}"
              "$mod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
            ]) 10
          ));
      };
    };
  };

  programs.waybar = {
    enable = true;
    catppuccin = {
      enable = true;
      mode = "createLink";
    };
    style = ./waybar.css;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "sway/mode" ];
        modules-center = [ "sway/workspaces" ];
        modules-right = [
          "tray"
          "clock"
        ];
        "sway/workspaces" = {
          format = ''{name} : {windows}'';
          format-window-separator = " | ";
          window-rewrite-default = "{name}";
          window-format = "{name}";
          window-rewrite = {
            "class<chromium-browser>" = "";
            "class<chrome-pjibgclleladliembfgfagdaldikeohf-Default>" = "󰓇";
            "class<alacritty>" = "";
          };
          sort-by-number = true;
          disable-scroll = true;
        };
        tray = {
          icon-size = 16;
          spacing = 10;
          show-passive-items = true;
        };
        clock = {
          interval = 1;
          format = "{:%c}";
        };
      };
    };
  };

  programs.tofi = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      border-width = 2;
      outline-width = 2;
      corner-radius = 4;
      width = "40%";
      height = "20%";
      font = "monospace";
      font-size = 14;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
  };

  # You'll need this
  programs.alacritty = {
    enable = true;
    catppuccin.enable = true;
  };

  # And this
  programs.chromium = {
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
}
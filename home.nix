{ pkgs, lib, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alxdb";
  home.homeDirectory = "/home/alxdb";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    htop
    wl-clipboard
  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'.
  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Catppuccin flavour 
  catppuccin.flavour = "mocha";

  # Window Manager Configuration + basic apps
  wayland.windowManager = {
    sway = rec {
      enable = true;
      catppuccin.enable = true;
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
          };
        output = {
          "*" = {
            bg = "$base solid_color";
          };
          "DP-1" = {
            scale = "1.5";
          };
          "DP-2" = {
            transform = "270";
            position = "-1920 0";
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
            indicator = "$rosewater";
            border = "$lavender";
          };
          focusedInactive = {
            childBorder = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$rosewater";
            border = "$overlay0";
          };
          unfocused = {
            childBorder = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$rosewater";
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
    catppuccin.enable = true;
    style = ''
      * {
        font-family: monospace;
        font-size: 12px;
        min-height: 1rem;
      }

      #waybar {
        background: transparent;
        color: @text;
        margin: 1rem;
        padding: 1rem;
      }

      #tray,
      #clock
      {
        border-radius: 1rem 0 0 1rem;
        background-color: @surface1;
      }

      #clock {
        padding: 0 1rem;
        color: @blue;
      }

      #workspaces {
        margin: 0 1rem;
        padding: 0;
        border-radius: 1rem;
        background-color: @surface0;
      }

      #workspaces button {
        color: @lavender;
        border-radius: 1rem;
        padding: 0.4rem;
        background-color: @surface0;
      }

      #workspaces button.focused {
        color: @sky;
        background-color: @surface1;
      }
      #workspaces button:hover {
        color: @sapphire;
        border-radius: 1rem;
      }
    '';
    settings = {
      mainBar = {
        layer = "top";
        modules-center = [ "sway/window" ];
        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        modules-right = [
          "tray"
          "clock"
        ];
        position = "top";
        "wlr/workspaces" = {
          disable-scroll = true;
          format = " {name} ";
          format-icons = {
            default = " ";
          };
          sort-by-name = true;
        };
        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
  };

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

  programs.alacritty = {
    enable = true;
    catppuccin.enable = true;
  };

  # Shell configuration
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
      lg = "lazygit";
      vf = ''
        vi +':lua require("telescope.builtin").fd()'
      '';
    };

    loginExtra = ''
      if [[ $(tty) = /dev/tty1 ]]; then
        exec sway
      fi
    '';
  };
  programs.starship = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      aws = {
        symbol = "  ";
      };
      buf = {
        symbol = " ";
      };
      c = {
        symbol = " ";
      };
      conda = {
        symbol = " ";
      };
      crystal = {
        symbol = " ";
      };
      dart = {
        symbol = " ";
      };
      directory = {
        read_only = " 󰌾";
      };
      docker_context = {
        symbol = " ";
      };
      elixir = {
        symbol = " ";
      };
      elm = {
        symbol = " ";
      };
      fennel = {
        symbol = " ";
      };
      fossil_branch = {
        symbol = " ";
      };
      git_branch = {
        symbol = " ";
      };
      golang = {
        symbol = " ";
      };
      guix_shell = {
        symbol = " ";
      };
      haskell = {
        symbol = " ";
      };
      haxe = {
        symbol = " ";
      };
      hg_branch = {
        symbol = " ";
      };
      hostname = {
        ssh_symbol = " ";
      };
      java = {
        symbol = " ";
      };
      julia = {
        symbol = " ";
      };
      kotlin = {
        symbol = " ";
      };
      lua = {
        symbol = " ";
      };
      memory_usage = {
        symbol = "󰍛 ";
      };
      meson = {
        symbol = "󰔷 ";
      };
      nim = {
        symbol = "󰆥 ";
      };
      nix_shell = {
        symbol = " ";
      };
      nodejs = {
        symbol = " ";
      };
      ocaml = {
        symbol = " ";
      };
      os = {
        symbols = {
          Alpaquita = " ";
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          RedHatEnterprise = " ";
          Redhat = " ";
          Redox = "󰀘 ";
          SUSE = " ";
          Solus = "󰠳 ";
          Ubuntu = " ";
          Unknown = " ";
          Windows = "󰍲 ";
          openSUSE = " ";
        };
      };
      package = {
        symbol = "󰏗 ";
      };
      perl = {
        symbol = " ";
      };
      php = {
        symbol = " ";
      };
      pijul_channel = {
        symbol = " ";
      };
      python = {
        symbol = " ";
      };
      rlang = {
        symbol = "󰟔 ";
      };
      ruby = {
        symbol = " ";
      };
      rust = {
        symbol = " ";
      };
      scala = {
        symbol = " ";
      };
      swift = {
        symbol = " ";
      };
      zig = {
        symbol = " ";
      };
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
      ## nix
      pkgs.nixfmt-rfc-style
      pkgs.nil
      ## lua
      pkgs.stylua
      pkgs.lua-language-server
      ## json,yaml,toml,md,etc...
      pkgs.vscode-langservers-extracted
      pkgs.yaml-language-server
      pkgs.prettierd
      pkgs.taplo
      ## css,html,js,ts,etc...
      pkgs.tailwindcss-language-server
      pkgs.nodePackages.typescript-language-server
      ## go
      pkgs.gopls
      ## protobuf
      pkgs.buf-language-server
      pkgs.buf
      ## purescript
      pkgs.nodePackages.purescript-language-server
      pkgs.dhall-lsp-server
      ## rust
      pkgs.rust-analyzer
      pkgs.rustc
      pkgs.rustfmt
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
    ignores = [
      ".envrc"
      ".direnv"
      "result"
    ];
  };
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
  programs.ssh.enable = true;
  services.ssh-agent.enable = true;
  programs.lazygit.enable = true;

  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}

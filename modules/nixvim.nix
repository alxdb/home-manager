{ pkgs, ... }:
{
  programs.nixvim = { helpers, ... }: {
    enable = true;

    # Command settings
    defaultEditor = true;
    vimdiffAlias = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.catppuccin = {
      enable = true;
      settings = { flavour = "mocha"; };
    };

    extraPackages = with pkgs; [
      neovim-remote
      ripgrep # for Telescope live_grep
    ];

    # Vim settings
    globals = {
      mapleader = " ";
      laststatus = 3;
    };
    opts = {
      foldlevelstart = 99;
      number = true;
      signcolumn = "number";
    };
    keymaps = [
      {
        action = ":cd %:h<cr>";
        key = "<leader>cd";
        options = {
          silent = true;
          desc = "change directory to current buffer";
        };
      }
      {
        action = '':s/[a-z]\@<=[A-Z]/_\l\0/g<cr>'';
        key = "<leader>tc";
        options = {
          silent = true;
          desc = "camel case to snake case";
        };
      }
      {
        action = '':s/_\([a-z]\)/\u\1/g<cr>'';
        key = "<leader>tc";
        options = {
          silent = true;
          desc = "snake case to camel case";
        };
      }
      {
        action = ":ZenMode<cr>";
        key = "<leader>wz";
        options = {
          silent = true;
          desc = "toggle zen mode";
        };
      }
      {
        action = ":Neogit<cr>";
        key = "<leader>gg";
        options = {
          silent = true;
          desc = "open neogit";
        };
      }
      {
        action = ":Neotree<cr>";
        key = "<leader>ft";
        options = {
          silent = true;
          desc = "open neotree";
        };
      }
      {
        action = ":Gitsigns preview_hunk<cr>";
        key = "<leader>gp";
        options = {
          silent = true;
          desc = "preview current hunk";
        };
      }
      {
        action = ":Bdelete<cr>";
        key = "<leader>bd";
        options = {
          silent = true;
          desc = "delete buffer (keep windows)";
        };
      }
    ];

    plugins = {
      # editing
      sleuth.enable = true;
      surround.enable = true;
      autoclose.enable = true;
      bufdelete.enable = true;
      # user interface
      lualine = {
        enable = true;
        sections = {
          lualine_b = [
            {
              name = "branch";
              icon = "";
            }
            "diff"
            "diagnostics"
          ];
          lualine_c = [];
          lualine_x = ["filetype"];
        };
      };
      bufferline = {
        enable = true;
        showBufferCloseIcons = false;
      };
      noice.enable = true;
      neo-tree = {
        enable = true;
        
      };
      which-key.enable = true;
      zen-mode.enable = true;
      neogit.enable = true;
      gitsigns = {
        enable = true;

      };
      telescope = {
        enable = true;
        settings = {
          defaults = { file_ignore_patterns = [ "^.git/" "^.git$" ]; };
          pickers = { find_files = { hidden = true; }; };
        };
        keymaps = {
          "<leader>ff" = {
            action = "git_files";
            options.desc = "telescope: git files";
          };
          "<leader>fF" = {
            action = "find_files";
            options.desc = "telescope: all files";
          };
          "<leader>fg" = {
            action = "live_grep";
            options.desc = "telescope: grep files";
          };
          "<leader>bf" = {
            action = "buffers";
            options.desc = "telescope: buffers";
          };
          "<leader>cs" = {
            action = "commands";
            options.desc = "telescope: commands";
          };
        };
      };
      toggleterm = {
        enable = true;
        settings = {
          open_mapping = ''[[<C-\>]]'';
        };
      };
      # language support
      treesitter = {
        enable = true;
        folding = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          incremental_selection.enable = true;
        };
      };
      treesitter-context.enable = true;
      lsp = {
        enable = true;
        keymaps = {
          lspBuf = {
            K = "hover";
            gr = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
          };
          diagnostic = { gl = "open_float"; };
          extra = [{
            action = helpers.mkRaw #lua
            ''
              function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
              end
            '';
            key = "<leader>li";
            mode = "n";
            options = {
              silent = true;
              desc = "lsp: toggle inlay hints";
            };
          }];
        };
        servers = {
          nil-ls = {
            enable = true;
            settings = {
              formatting.command = ["nixfmt"];
            };
          };
          yamlls.enable = true;
          jsonls.enable = true;
          taplo.enable = true;
          pylsp = {
            enable = true;
            settings.plugins = {
              pycodestyle.enabled = false;
              ruff.enabled = true;
              pylsp_mypy.enabled = true;
            };
          };
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          hls = {
            enable = true;
            filetypes = ["haskell" "lhaskell" "cabal"];
            settings.haskell = {
              cabalFormattingProvider = "cabal-fmt";
              formattingProvider = "fourmolu";
            };
          };
        };
      };
      lsp-format.enable = true;
      none-ls = {
        enable = true;
        sources = {
          formatting = {
            prettierd.withArgs = /* lua */ ''{ filetypes = { "css", "yaml" } }'';
          };
        };
      };
      luasnip = {
        enable = true;
        extraConfig = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            "<C-Space>" = /* lua */ "cmp.mapping.complete()";
            "<Esc>" = /* lua */ "cmp.mapping.close()";
            "<CR>" = /* lua */ "cmp.mapping.confirm({ select = true })";
            "<Tab>" =/* lua */ "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<C-n>" =/* lua */ "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<C-p>" =/* lua */ "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
          snippet.expand = /* lua */ ''
            function(args)
              require("luasnip").lsp_expand(args.body)
            end
          '';
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };
    };
  };
}

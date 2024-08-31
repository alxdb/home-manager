{ pkgs, ... }:
{
  # TODO: upstream manual config
  programs.nixvim =
    { helpers, ... }:
    {
      enable = true;

      # Command settings
      defaultEditor = true;
      vimdiffAlias = true;
      viAlias = true;
      vimAlias = true;

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
        };
      };

      extraPackages = with pkgs; [
        neovim-remote
        ripgrep # for Telescope live_grep
        nixfmt-rfc-style # nix formatter (not installed by default)
        haskell-language-server
      ];

      extraConfigLua = ''
        require("overseer").setup()
      '';

      extraPlugins = with pkgs.vimPlugins; [
        overseer-nvim
        haskell-tools-nvim
        nlsp-settings-nvim
      ];

      # Vim settings
      globals = {
        mapleader = " ";
        haskell_tools = {
          tools = {
            repl = {
              handler = "toggleterm";
            };
          };
          hls = {
            on_attach = helpers.mkRaw ''
              function(client, bufnr, ht) 
                require("lsp-format").on_attach(client) 
              end
            '';
          };
        };
      };
      opts = {
        number = true;
        signcolumn = "number";
        # Default indentation (overridden by sleuth)
        tabstop = 4;
        shiftwidth = 4;
        # Global statusbar
        laststatus = 3;
        # Treesitter folds
        foldmethod = "expr";
        foldexpr = "nvim_treesitter#foldexpr()";
        foldenable = true;
        foldlevel = 9999;
        exrc = true;
      };
      keymaps = [
        # Text Manipulation
        {
          action = ":s/[a-z]\\@<=[A-Z]/_\\l\\0/g<cr>";
          key = "<leader>tc";
          mode = "v";
          options = {
            silent = true;
            desc = "camel case to snake case";
          };
        }
        {
          action = ":s/_\\([a-z]\\)/\\u\\1/g<cr>";
          key = "<leader>tc";
          mode = "v";
          options = {
            silent = true;
            desc = "snake case to camel case";
          };
        }
        # Shortcuts
        {
          action = ":cd %:h<cr>";
          key = "<leader>cd";
          mode = "n";
          options = {
            silent = true;
            desc = "change directory to current buffer";
          };
        }
        {
          action = ":bp<cr>";
          key = "H";
          mode = "n";
          options = {
            silent = true;
            desc = "previous buffer";
          };
        }
        {
          action = ":bn<cr>";
          key = "L";
          mode = "n";
          options = {
            silent = true;
            desc = "next buffer";
          };
        }
        {
          action = ":noh<cr>";
          key = "<Esc>";
          mode = "n";
          options = {
            silent = true;
            desc = "clear highlight";
          };
        }
        {
          action = ":b#<cr>";
          key = "<leader><tab>";
          mode = "n";
          options = {
            silent = true;
            desc = "swap buffer";
          };
        }
        {
          action = ":q<cr>";
          key = "<leader>q";
          mode = "n";
          options = {
            silent = true;
            desc = "exit";
          };
        }
        # Commands
        {
          action = "<cmd>FormatToggle<cr>";
          key = "<leader>lf";
          mode = "n";
          options.desc = "toggle auto format";
        }
        {
          action = "<cmd>ZenMode<cr>";
          key = "<leader>wz";
          mode = "n";
          options.desc = "toggle zen mode";
        }
        {
          action = "<cmd>Neogit<cr>";
          key = "<leader>gg";
          mode = "n";
          options.desc = "open neogit";
        }
        {
          action = "<cmd>Neotree<cr>";
          key = "<leader>ft";
          mode = "n";
          options.desc = "open neotree";
        }
        {
          action = "<cmd>Gitsigns preview_hunk<cr>";
          key = "<leader>gp";
          mode = "n";
          options.desc = "preview current hunk";
        }
        {
          action = "<cmd>Gitsigns reset_hunk<cr>";
          key = "<leader>gr";
          mode = "n";
          options.desc = "reset current hunk";
        }
        {
          action = "<cmd>Bdelete<cr>";
          key = "<leader>bd";
          mode = "n";
          options.desc = "delete buffer (keep windows)";
        }
        {
          action = "<cmd>OverseerRun<cr>";
          key = "<leader>tr";
          mode = "n";
          options.desc = "run Task";
        }
        {
          action = "<cmd>OverseerToggle<cr>";
          key = "<leader>tt";
          mode = "n";
          options.desc = "view Tasks";
        }
        {
          action = "<cmd>OverseerLoadBundle<cr>";
          key = "<leader>tl";
          mode = "n";
          options.desc = "load Task";
        }
        {
          action = "<cmd>OverseerQuickAction<cr>";
          key = "<leader>ta";
          mode = "n";
          options.desc = "task action";
        }
        {
          action = "<cmd>ToggleTerm direction=vertical<cr>";
          key = "<leader>\\v";
          mode = "n";
          options.desc = "toggleterm: vertical";
        }
        {
          action = "<cmd>ToggleTerm direction=float<cr>";
          key = "<leader>\\f";
          mode = "n";
          options.desc = "toggleterm: float";
        }
      ];

      plugins = {
        # editing
        sleuth.enable = true;
        surround.enable = true;
        nvim-autopairs.enable = true;
        bufdelete.enable = true;
        better-escape.enable = true;
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
              "overseer"
            ];
            lualine_c = [ ];
            lualine_x = [ "filetype" ];
          };
        };
        bufferline = {
          enable = true;
          showBufferCloseIcons = false;
        };
        noice.enable = true;
        neo-tree = {
          enable = true;
          filesystem = {
            groupEmptyDirs = true;
          };
        };
        which-key.enable = true;
        zen-mode.enable = true;
        diffview.enable = true;
        neogit = {
          enable = true;
          settings = {
            kind = "replace";
          };
        };
        git-conflict.enable = true;
        gitsigns.enable = true;
        telescope = {
          enable = true;
          settings = {
            defaults = {
              file_ignore_patterns = [
                "^.git/"
                "^.git$"
              ];
            };
            pickers = {
              find_files = {
                hidden = true;
              };
            };
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
          extensions = {
            ui-select.enable = true;
          };
        };
        toggleterm = {
          enable = true;
          settings = {
            open_mapping = "[[<C-\\>]]";
            size = ''
              function(term)
                if term.direction == "horizontal" then
                  return 35
                elseif term.direction == "vertical" then
                  return vim.o.columns * 0.4
                end
              end
            '';
          };
        };
        trouble.enable = true;
        neotest = {
          enable = true;
          adapters = {
            python.enable = true;
            gtest.enable = true;
            haskell.enable = true;
          };
        };
        # language support
        treesitter = {
          enable = true;
          folding = true;
          settings = {
            highlight.enable = true;
            indent = {
              enable = true;
              disable = [ "yaml" ];
            };
            incremental_selection.enable = true;
          };
        };
        treesitter-context.enable = true;
        lsp = {
          enable = true;
          keymaps = {
            lspBuf = {
              K = {
                action = "hover";
                desc = "lsp: hover";
              };
              gr = {
                action = "references";
                desc = "lsp: references";
              };
              gd = {
                action = "definition";
                desc = "lsp: definition";
              };
              gi = {
                action = "implementation";
                desc = "lsp: implementation";
              };
              gt = {
                action = "type_definition";
                desc = "lsp: type definition";
              };
              "<leader>lr" = {
                action = "rename";
                desc = "lsp: rename";
              };
              "<leader>la" = {
                action = "code_action";
                desc = "lsp: code action";
              };
            };
            diagnostic = {
              gl = {
                action = "open_float";
                desc = "lsp: open diagnostics float";
              };
            };
            extra = [
              {
                action = helpers.mkRaw ''
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
              }
            ];
          };
          servers = {
            nil-ls = {
              enable = true;
              settings = {
                formatting.command = [ "nixfmt" ];
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
                pylsp_mypy = {
                  enabled = true;
                  report_progress = true;
                };
              };
            };
            cmake.enable = true;
            clangd = {
              enable = true;
              filetypes = [
                "c"
                "cpp"
              ];
            };
            zls = {
              enable = true;
              settings.zls = {
                enable_build_on_save = true;
                warn_style = true;
                highlight_global_var_declarations = true;
                enable_autofix = true;
              };
            };
            gopls.enable = true;
            bufls.enable = true;
          };
        };
        typescript-tools.enable = true;
        rustaceanvim.enable = true;
        lsp-format = {
          enable = true;
          setup = {
            toml.sync = true;
          };
        };
        none-ls = {
          enable = true;
          sources = {
            formatting = {
              prettierd = {
                enable = true;
                settings = ''{ filetypes = { "css", "yaml" } }'';
              };
              buf.enable = true;
            };
            diagnostics = {
              codespell = {
                enable = true;
                settings = {
                  extra_args = [ "-L noice,shouldBe,crate" ];
                };
              };
            };
          };
        };
        luasnip = {
          enable = true;
          settings = {
            enable_autosnippets = true;
            store_selection_keys = "<Tab>";
          };
        };
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<C-f>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            };
            snippet.expand = ''
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

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

      # Colorscheme
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
        };
      };

      # Extra Config
      extraPackages = with pkgs; [
        neovim-remote
        ripgrep # for Telescope live_grep
        nixfmt-rfc-style # nix formatter (not installed by default)
      ];

      # Options & Globals
      globals = {
        mapleader = " ";
        # Toggle this value to (dis/en)able LSP format on save
        format_on_save = 1;
      };

      opts = {
        number = true;
        signcolumn = "number";
        # Default indentation (overridden by sleuth)
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        # Global statusbar
        laststatus = 3;
        # Treesitter folds
        foldmethod = "expr";
        foldexpr = "nvim_treesitter#foldexpr()";
        foldenable = true;
        foldlevel = 9999;
        # Evaluate exrc files
        exrc = true;
      };

      # Key Mappings
      keymaps = [
        {
          action = ":qa<cr>";
          mode = "n";
          key = "<leader>q";
          options = {
            silent = true;
            desc = "Quit";
          };
        }
        {
          action = ":qa!<cr>";
          mode = "n";
          key = "<leader>Q";
          options = {
            silent = true;
            desc = "Quit without saving";
          };
        }
        {
          action = ":b#<cr>";
          mode = "n";
          key = "<BS>";
          options = {
            silent = true;
            desc = "Last used buffer";
          };
        }
        {
          action = "<cmd>Bdelete<cr>";
          mode = "n";
          key = "<leader>bd";
          options = {
            silent = true;
            desc = "Delete buffer";
          };
        }
        {
          action = ":w<cr>";
          mode = "n";
          key = "<leader>bw";
          options = {
            silent = true;
            desc = "Write buffer";
          };
        }
        {
          action = "<cmd>ZenMode<cr>";
          mode = "n";
          key = "<C-w>z";
          options = {
            silent = true;
            desc = "Zen Mode";
          };
        }
        {
          action = "<cmd>Neogit kind=floating<cr>";
          mode = "n";
          key = "<leader>og";
          options = {
            silent = true;
            desc = "Git";
          };
        }
        {
          action = "<cmd>Neotree float<cr>";
          mode = "n";
          key = "<leader>of";
          options = {
            silent = true;
            desc = "File Manager";
          };
        }
        {
          action = "<cmd>ToggleTerm direction=float<cr>";
          mode = "n";
          key = "<leader>ot";
          options = {
            silent = true;
            desc = "Terminal";
          };
        }
      ];

      # AutoCmd
      autoCmd = [ ];

      # LSP Settings
      lsp = {
        onAttach = # lua
          ''
            if client.supports_method('textDocument/formatting') then
              -- Format the current buffer on save
              vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = bufnr,
                callback = function()
                  if vim.g.format_on_save == 1 then
                    vim.lsp.buf.format({bufnr = bufnr, id = client.id})
                  end
                end,
              })
            end
          '';
      };

      # Plugins
      plugins = {
        # editing
        sleuth.enable = true;
        vim-surround.enable = true;
        nvim-autopairs.enable = true;
        bufdelete.enable = true;
        ts-autotag.enable = true; # autoclose/autorename xml/html tags
        ts-comments.enable = true;
        # user interface
        web-devicons.enable = true;
        lualine = {
          enable = true;
          settings = {
            options = {
              section_separators = "";
              component_separators = "";
            };
            sections = {
              lualine_b = [
                {
                  __unkeyed = "branch";
                  icon = "";
                }
                "diff"
                "diagnostics"
              ];
              lualine_c = [ ];
              lualine_x = [ "filetype" ];
            };
          };
        };
        noice.enable = true;
        neo-tree = {
          enable = true;
          filesystem = {
            groupEmptyDirs = true;
          };
        };
        which-key = {
          enable = true;
          settings.spec = [
            {
              __unkeyed = "<leader>f";
              group = "Find";
              icon = " ";
            }
            {
              __unkeyed = "<leader>l";
              group = "Language";
              icon = " ";
            }
            {
              __unkeyed = "<leader>o";
              group = "Open";
              icon = "󰏋 ";
            }
            {
              __unkeyed = "<leader>b";
              group = "Buffer";
              icon = " ";
            }
          ];
        };
        zen-mode.enable = true;
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
            "<leader>fb" = {
              action = "buffers";
              options.desc = "telescope: buffers";
            };
            "<leader>fc" = {
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
            nil_ls = {
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
              package = null;
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
            wgsl_analyzer = {
              enable = true;
              package = null;
            };
            hls = {
              enable = true;
              package = null;
              installGhc = false;
            };
          };
        };
        # Extra language plugins
        typescript-tools.enable = true;
        rustaceanvim = {
          enable = true;
          settings = {
            tools = {
              executor = "toggleterm";
              test_executor = "neotest";
              crate_test_executor = "neotest";
            };
          };
        };
        # LSP extensions
        none-ls = {
          enable = true;
          settings = {
            on_attach = "format_on_save_hook";
          };
          sources = {
            formatting = {
              prettierd = {
                enable = true;
                settings = ''{ filetypes = { "json", "yaml", "css", "html" } }'';
              };
              buf.enable = true;
            };
            diagnostics = {
              codespell = {
                enable = true;
                settings = {
                  extra_args = [ "-L noice,shouldBe,crate,ot" ];
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
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
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

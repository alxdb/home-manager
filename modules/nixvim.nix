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

      # Ad-hoc config
      extraPackages = with pkgs; [
        neovim-remote
        ripgrep # for Telescope live_grep
        nixfmt-rfc-style # nix formatter (not installed by default)
        haskell-language-server
      ];

      extraPlugins = with pkgs.vimPlugins; [
        overseer-nvim
        haskell-tools-nvim
        nlsp-settings-nvim
      ];

      extraConfigLuaPre = ''
        function autoformat_hook(client, bufnr)
          if client.supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              callback = function()
                if vim.g.autoformat == 1 then
                  vim.lsp.buf.format({bufnr = bufnr, id = client.id})
                end
              end,
            })
          end
        end
      '';

      extraConfigLua = ''
        require("overseer").setup()
      '';

      # Options & Globals
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
        autoformat = 1;
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
        exrc = true;
      };

      # Key Mappings
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
        # Custom
        {
          action = ":let g:autoformat=!g:autoformat<cr>";
          key = "<leader>lf";
          mode = "n";
          options.desc = "toggle auto format";
        }
        # Commands
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

      # AutoCmd
      autoCmd = [
        {
          callback = helpers.mkRaw ''
            function(args)
              vim.keymap.set('n', '<leader>lrd', '<cmd>RustLsp openDocs<cr>', { buffer = args.buf })
            end
          '';
          event = [
            "BufEnter"
            "BufWinEnter"
          ];
          pattern = [
            "*.rs"
          ];
        }
      ];

      plugins = {
        # editing
        sleuth.enable = true;
        vim-surround.enable = true;
        autoclose.enable = true;
        bufdelete.enable = true;
        better-escape.enable = true;
        ts-autotag.enable = true;
        ts-comments.enable = true;
        # user interface
        web-devicons.enable = true;
        lualine = {
          enable = true;
          settings.sections = {
            lualine_b = [
              {
                __unkeyed = "branch";
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
          settings.options.show_buffer_close_icons = false;
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
          onAttach = "autoformat_hook(client, bufnr)";
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
            bufls.enable = true;
            wgsl_analyzer = {
              enable = true;
              package = null;
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
            on_attach = "autoformat_hook";
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

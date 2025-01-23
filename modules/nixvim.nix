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

      extraConfigLuaPre = ''
        -- LSP attach hook for format on save
        function format_on_save_hook(client, bufnr)
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
        end
      '';

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
      keymaps = [ ];

      # AutoCmd
      autoCmd = [ ];

      plugins = {
        # editing
        sleuth.enable = true;
        vim-surround.enable = true;
        nvim-autopairs.enable = true;
        bufdelete.enable = true;
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
            ];
            lualine_c = [ ];
            lualine_x = [ "filetype" ];
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
              __unkeyed = "<leader>t";
              group = "Telescope";
              icon = " ";
            }
            {
              __unkeyed = "<leader>l";
              group = "Language";
              icon = " ";
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
            "<leader>tf" = {
              action = "git_files";
              options.desc = "telescope: git files";
            };
            "<leader>tF" = {
              action = "find_files";
              options.desc = "telescope: all files";
            };
            "<leader>tg" = {
              action = "live_grep";
              options.desc = "telescope: grep files";
            };
            "<leader>tb" = {
              action = "buffers";
              options.desc = "telescope: buffers";
            };
            "<leader>tc" = {
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
            open_mapping = "[[<C-/>]]";
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
          onAttach = "format_on_save_hook(client, bufnr)";
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

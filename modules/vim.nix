{ config, ... }:
let
  helpers = config.lib.nixvim;
in
{
  programs.nixvim =
    { ... }:
    {
      enable = true;
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

      globals = {
        mapleader = " ";
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
        # Evaluate exrc files
        exrc = true;
        # Folding options
        foldlevel = 4;
      };

      keymaps = [
        { mode = "n"; key = "gd"; action = "<C-]>"; }
      ];

      autoCmd = [
        {
          event = "QuickFixCmdPost";
          # copy (and replace) quickfix contents to diagnostics
          callback = helpers.mkRaw ''
            function()
              local ns = vim.api.nvim_create_namespace("quickfix")
              vim.diagnostic.reset(ns)
              local buf_diagnostics = {}
              
              local qflist = vim.fn.getqflist()
              for _, item in ipairs(qflist) do
                local bufnr = item.bufnr
                if bufnr > 0 then
                  if not buf_diagnostics[bufnr] then
                    buf_diagnostics[bufnr] = {}
                  end
                  table.insert(buf_diagnostics[bufnr], {
                    lnum = item.lnum - 1,
                    col = item.col - 1,
                    message = item.text,
                    severity = vim.diagnostic.severity.ERROR,
                  })
                end
              end
              
              for bufnr, diags in pairs(buf_diagnostics) do
                vim.diagnostic.set(ns, bufnr, diags)
              end
            end
          '';
        }
        # Remember fold configurations
        {
          event = "BufWinLeave";
          pattern = [ "*" ];
          command = "if &buftype == '' | mkview | endif";
        }
        {
          event = [ "BufWinEnter" ];
          pattern = [ "*" ];
          command = "if empty(&buftype) | silent! loadview | endif";
        }
      ];

      plugins.sleuth.enable = true;
      plugins.vim-surround.enable = true;
      plugins.nvim-autopairs = {
        enable = true;
        check_ts = true;
      };
      plugins.treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
      };
      plugins.which-key.enable = true;
      plugins.web-devicons.enable = true;
      plugins.lualine = {
        enable = true;
        disableDefaultConfig = true;
        settings = {
          options = {
            theme = "catppuccin";
            section_separators = {
              left = "";
              right = "";
            };
            component_separators = {
              left = "|";
              right = "|";
            };
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
            lualine_c = helpers.mkRaw "{}";
            lualine_x = [
              {
                __unkeyed = "filename";
                path = 1;
                shorting_target = 40;
              }
              {
                __unkeyed = "filetype";
                icon_only = true;
              }
            ];
          };
        };
      };

      plugins.lsp = {
        enable = true;
        keymaps = {
          lspBuf = {
            gq = "format";
            gd = "definition";
            K = "hover";
            gr = "references";
          };
        };
        servers = {
          nixd.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };
    };
  xdg.configFile."nvim/after/queries/cpp/highlights.scm".text = ''
    ; extends

    [
      "import"
      "export"
      "module"
    ] @keyword
  '';
}

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
    },
    init = function()
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    opts = {
      sections = {
        lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
        lualine_c = {},
        lualine_x = { "filetype" },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_c = {},
      },
      options = {
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "neo-tree" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        show_buffer_close_icons = false,
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
		},
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
    init = function()
      local wk = require("which-key")
      wk.register({
        f = { name = "files" },
        b = { name = "buffers" },
        g = { name = "git" },
        l = {
          name = "language",
          {
            t = { name = "toggles" },
            c = { name = "c/c++" },
          },
        },
        t = { name = "text" },
        d = { name = "directory" },
      }, { prefix = "<leader>" })
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {},
    keys = {
      {
        "<leader>wz",
        function()
          require("zen-mode").toggle()
        end,
				desc = "Open zen-mode",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      yadm = { enable = true },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local wk = require("which-key")

        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { buffer = bufnr, expr = true })
        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { buffer = bufnr, expr = true })

        wk.register({
          s = {
            name = "signs",
            s = { gs.stage_hunk, "stage hunk" },
            S = { gs.stage_buffer, "stage buffer" },
            r = { gs.reset_hunk, "reset hunk" },
            p = { gs.preview_hunk, "preview hunk" },
            b = { gs.toggle_current_line_blame, "blame line toggle" },
          },
        }, { prefix = "<leader>g" })
      end,
    },
  },
  {
    "f-person/git-blame.nvim",
    opts = {},
  },
  {
    "norcalli/nvim-colorizer.lua",
    opts = {},
  },
}

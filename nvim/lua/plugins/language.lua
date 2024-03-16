return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    main = "nvim-treesitter.configs";
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      local function on_attach(_, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
        lsp_zero.buffer_autoformat()
      end
      lsp_zero.on_attach(on_attach)
    end
  },
  {
    "williamboman/mason.nvim",
    config = true,
    build = ":MasonUpdate",
  },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "VonHeikemen/lsp-zero.nvim",
  --     "neovim/nvim-lspconfig",
  --     "folke/neodev.nvim",
  --   },
  --   opts = {
  --     ensure_installed = {
  --       "lua_ls",
  --       "jsonls",
  --       "rust_analyzer",
  --       "pylsp",
  --       "taplo",
  --       "tsserver",
  --       "tailwindcss",
  --       "eslint",
  --       "gopls",
  --       "yamlls",
  --       "bufls",
  --       "rnix",
  --       "dockerls",
  --     },
  --   },
  --   config = function(_, opts)
  --     require("mason-lspconfig").setup(
  --       vim.tbl_deep_extend("force", opts, {
  --         handlers = {
  --           require("lsp-zero").default_setup,
  --
  --           lua_ls = function()
  --             require("neodev").setup()
  --             require("lspconfig").lua_ls.setup({})
  --           end,
  --
  --           pylsp = function()
  --             require("lspconfig").pylsp.setup({
  --               plugins = {
  --                 ruff = { enabled = true },
  --                 pylsp_mypy = { enabled = true },
  --               },
  --             })
  --           end,
  --         },
  --       })
  --     )
  --   end,
  -- },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "williamboman/mason.nvim",
  --   },
  --   opts = {
  --     mason_packages = { "prettierd", "buf" },
  --   },
  --   config = function(_, opts)
  --     local mason_registry = require("mason-registry")
  --     for _, package_name in ipairs(opts.mason_packages) do
  --       local package = mason_registry.get_package(package_name)
  --       if not package:is_installed() then
  --         package:install()
  --       end
  --     end
  --
  --     local null_ls = require("null-ls")
  --     null_ls.setup(
  --       vim.tbl_deep_extend("force", opts, {
  --         sources = {
  --           null_ls.builtins.formatting.prettierd.with({
  --             filetypes = { "css", "yaml" },
  --           }),
  --           null_ls.builtins.diagnostics.buf,
  --           null_ls.builtins.formatting.buf,
  --         },
  --       })
  --     )
  --   end,
  -- },
}

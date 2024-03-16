return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		main = "nvim-treesitter.configs",
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

			local lspconfig = require("lspconfig")
			lspconfig.nil_ls.setup({})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.nixfmt,
					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},
}

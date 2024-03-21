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
			"folke/neodev.nvim",
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			local function on_attach(_, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
				lsp_zero.buffer_autoformat()
			end
			lsp_zero.on_attach(on_attach)

			local lspconfig = require("lspconfig")
			-- nix lsp
			lspconfig.nil_ls.setup({
				settings = {
					["nil"] = {
						formatting = {
							command = { "nixfmt" },
						},
					},
					nix = {
						flake = {
							autoArchive = true,
						},
					},
				},
			})

			-- lua/neovim lsp
			require("neodev").setup({})
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						format = {
							enable = false,
						},
					},
				},
			})

			-- data format lsps
			lspconfig.jsonls.setup({})
			lspconfig.yamlls.setup({})
			lspconfig.taplo.setup({})

			-- (type|java)script lsp
			lspconfig.tsserver.setup({})
			lspconfig.tailwindcss.setup({})
			-- no nixpkgs for eslint as it should be installed by the project
			lspconfig.eslint.setup({})

			-- go
			lspconfig.gopls.setup({})
			lspconfig.bufls.setup({})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettierd.with({
						filetypes = { "css", "yaml" },
					}),
					null_ls.builtins.diagnostics.buf,
					null_ls.builtins.formatting.buf,
				},
			})
		end,
	},
}

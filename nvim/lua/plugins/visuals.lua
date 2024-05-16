return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			defaults = {
				mode = { "n", "v" },
				["<leader>f"] = { name = "files" },
				["<leader>b"] = { name = "buffers" },
				["<leader>g"] = { name = "git" },
				["<leader>w"] = { name = "window" },
				["<leader>l"] = { name = "language" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
	{
		"alxdb/nord-dark.nvim",
		main = "nord",
		lazy = false,
		priority = 1000,
		config = true,
		init = function()
			vim.cmd.colorscheme("nord")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "alxdb/nord-dark.nvim" },
		opts = {
			sections = {
				lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
				lualine_c = {},
				lualine_x = { "filetype" },
			},
			inactive_sections = {
				lualine_c = {},
			},
			winbar = {
				lualine_b = { { "buffers", show_filename_only = false } },
			},
			inactive_winbar = {
				lualine_b = { { "buffers", show_filename_only = false } },
			},
			options = {
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
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
			"rcarriga/nvim-notify",
		},
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
}

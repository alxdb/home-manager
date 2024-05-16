return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Telescope (find) Files",
			},
			{
				"<leader>bb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Telescope (browse) Buffers",
			},
			{
				"<leader>fs",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Telescope (search in) Files",
			},
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		init = function(_)
			require("telescope").load_extension("file_browser")
		end,
		keys = {
			{
				"<leader>fb",
				function()
					require("telescope").extensions.file_browser.file_browser()
				end,
				desc = "Telescope file browser",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "folke/which-key.nvim" },
		opts = {
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
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>gl",
				"<cmd>LazyGit<cr>",
				desc = "LazyGit",
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = [[<C-\>]],
		},
	},
}

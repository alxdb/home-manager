return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Search Files",
      },
      {
        "<leader>bf",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Find Buffers",
      },
      {
        "<leader>gf",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Git files",
      },
      {
        "<leader>c",
        function()
          require("telescope.builtin").commands()
        end,
        desc = "Telescope Commands",
      },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvimlua/plenary.nvim" },
    keys = {
      {
        "<leader>fb",
        "<cmd>Telescope file_browser<cr>",
        desc = "File Browser (telescope)",
      },
    },
  },
  {
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
        { "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<C-\>]],
      direction = "float",
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        group_empty_dirs = true,
      },
    },
    keys = {
      {
        "<leader>ft",
        "<cmd>Neotree<cr>",
        desc = "File Tree (neotree)",
      },
    },
  },
}

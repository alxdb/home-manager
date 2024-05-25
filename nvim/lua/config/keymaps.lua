vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<ESC>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "H", ":bp<CR>", { silent = true })
vim.keymap.set("n", "L", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader><TAB>", ":b#<CR>", { silent = true, desc = "swap buffer" })

vim.keymap.set("n", "<leader>bd", ":bd<CR>", { silent = true, desc = "delete" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { silent = true, desc = "exit" })

vim.keymap.set("n", "<leader>dc", ":cd %:h<CR>",
  { silent = true, desc = "change working directory to current file" })

vim.keymap.set("v", "<leader>tc", [[:s/[a-z]\@<=[A-Z]/_\l\0/g<CR>]],
  { silent = true, desc = "camel case to snake case" })
vim.keymap.set("v", "<leader>tC", [[:s/_\([a-z]\)/\u\1/g<CR>]],
  { silent = true, desc = "snake case to camel case" })

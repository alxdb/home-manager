vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<ESC>", ":nohlsearch<CR>", { silent = true })

vim.keymap.set("n", "<leader>bd", ":bd<CR>", { silent = true })
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { silent = true })

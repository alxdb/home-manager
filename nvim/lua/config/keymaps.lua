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

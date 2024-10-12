vim.g.mapleader = " "

vim.keymap.set("n", "<PageUp>", "<C-u>", { desc = "Scroll half page up" })
vim.keymap.set("n", "<PageDown>", "<C-d>", { desc = "Scroll half page down" })

vim.keymap.set("n", "<C-_>", ":nohl<CR>", { desc = "Clear search highlights", silent = true })

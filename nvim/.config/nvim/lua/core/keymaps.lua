vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("t", [[<C-/>]], [[<C-\><C-n>]], { desc = "Escape terminal mode" })

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

vim.keymap.set("n", "<M-s>", "<cmd>w<CR>", { desc = "Save current file" })

vim.keymap.set("n", "<C-w><S-Left>",  "<C-w><S-h>", { desc = "Rotate current window left" })
vim.keymap.set("n", "<C-w><S-Down>",  "<C-w><S-j>", { desc = "Rotate current window down" })
vim.keymap.set("n", "<C-w><S-Up>",    "<C-w><S-k>", { desc = "Rotate current window up" })
vim.keymap.set("n", "<C-w><S-Right>", "<C-w><S-l>", { desc = "Rotate current window right" })

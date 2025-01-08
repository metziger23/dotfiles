vim.g.mapleader = " "

vim.keymap.set("t", [[<C-/>]], [[<C-\><C-n>]], { desc = "Escape terminal mode" })

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

vim.keymap.set("n", "<M-s>", "<cmd>w<CR>", { desc = "Save current file" })

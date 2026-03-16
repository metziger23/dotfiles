vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("t", [[<C-/>]], [[<C-\><C-n>]], { desc = "Escape terminal mode" })

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

vim.keymap.set("n", "<C-w><S-Left>", "<C-w><S-h>", { desc = "Rotate current window left" })
vim.keymap.set("n", "<C-w><S-Down>", "<C-w><S-j>", { desc = "Rotate current window down" })
vim.keymap.set("n", "<C-w><S-Up>", "<C-w><S-k>", { desc = "Rotate current window up" })
vim.keymap.set("n", "<C-w><S-Right>", "<C-w><S-l>", { desc = "Rotate current window right" })

vim.keymap.set("n", "<M-s>", "<cmd>w<CR>", { desc = "Save current buffer" })
vim.keymap.set("n", "<M-C-s>", "<cmd>wa<CR>", { desc = "Save all buffers" })
vim.keymap.set("n", "<M-e>", "<cmd>q<CR>", { desc = "Exit current buffer" })
vim.keymap.set("n", "<M-C-e>", "<cmd>qa<CR>", { desc = "Exit all buffers" })

vim.keymap.set("n", "<M-q>", "q:", { desc = "Open cmdline window" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

local hydra_utils = require("../utils/hydra_utils")

hydra_utils.setup_bidirectional_hydra("n", "quickfix", "[q", "]q", vim.cmd.cprev, vim.cmd.cnext)

vim.api.nvim_del_keymap("n", "grn")
vim.api.nvim_del_keymap("n", "gra")
vim.api.nvim_del_keymap("x", "gra")
vim.api.nvim_del_keymap("n", "grr")
vim.api.nvim_del_keymap("n", "gri")
vim.api.nvim_del_keymap("n", "grt")

vim.keymap.set("x", "z/", "<C-\\><C-n>`</\\%V", { desc = "Search forward within visual selection" })
vim.keymap.set("x", "z?", "<C-\\><C-n>`>?\\%V", { desc = "Search backward within visual selection" })

local function put_linewise_with_filter(regname, pastecmd)
	local reg_type = vim.fn.getregtype(regname)
	local reg_content = vim.fn.getreg(regname)
	reg_content = reg_content:gsub("\n+$", "")
	-- reg_content = reg_content:gsub("%s*$", " ")
	-- reg_content = reg_content:gsub("^%s*", " ")
	vim.fn.setreg(regname, reg_content, "l") -- NOTE: "l" for linewise
	vim.cmd('normal "' .. regname .. pastecmd)
	vim.cmd("silent '[,']normal! ==") -- NOTE: filtering
	vim.fn.setreg(regname, reg_content, reg_type)
end

vim.api.nvim_set_keymap("n", "<leader>P", "Put linewise before the cursor", {
	noremap = true,
	silent = true,
	callback = function()
		put_linewise_with_filter(vim.v.register, "P")
	end,
})

vim.api.nvim_set_keymap("n", "<leader>p", "Put linewise after the cursor", {
	noremap = true,
	silent = true,
	callback = function()
		put_linewise_with_filter(vim.v.register, "p")
	end,
})

vim.keymap.set("n", "<leader>qn",
  "<cmd>mksession! /tmp/nvim-session.vim | restart source /tmp/nvim-session.vim<cr>",
  { desc = "Restart neovim"}
)

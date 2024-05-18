local lazygit_config_path = vim.fn.expand("$HOME/.config/lazygit/lazygit-nvim-remote-config.yml")
local lazygit = "lazygit -ucf " .. lazygit_config_path
local lazygit_params = "--opener=edit --titleposition=center --height=0.9 --width=0.9"

return {
	{
		"voldikss/vim-floaterm",
		cmd = { "FloatermNew", "FloatermToggle", "FloatermNext", "FloatermPrev", "FloatermLast", "FloatermFirst" },
    --stylua: ignore
    keys = {
      { "<leader>gg", "<cmd>FloatermNew --name=lazygitroot " .. lazygit_params .. " --cwd=<root> " .. lazygit .. "<CR>", desc = "Lazygit (root dir)" },
      { "<leader>gG", "<cmd>FloatermNew --name=lazygitbuffer " .. lazygit_params .. " --cwd=<buffer> " .. lazygit .. "<CR>", desc = "Lazygit (cwd)" },
      { "<leader>gh", function()
        local git_path = vim.api.nvim_buf_get_name(0)
        vim.api.nvim_command("FloatermNew --name=lazygitroot " .. lazygit_params .. " " .. lazygit .. " -f " .. vim.trim(git_path))
      end, desc = "LazyGit File History (LazyGit)" },
      { "<S-Right>", "<Esc><Esc><cmd>FloatermNext<CR>", mode = { "t" }, desc = "Next Terminal" },
      { "<S-Left>", "<Esc><Esc><cmd>FloatermPrev<CR>", mode = { "t" }, desc = "Prev Terminal" },
      { "<A-Right>", "<Esc><Esc><cmd>FloatermLast<CR>", mode = { "t" }, desc = "Last Terminal" },
      { "<A-Left>", "<Esc><Esc><cmd>FloatermFirst<CR>", mode = { "t" }, desc = "First Terminal" },
      { [[<c-\>]], "<cmd>FloatermToggle<cr>", mode = { "n", "t" }, desc = "Toggle Terminal" },
      { "<leader>ftf", "<cmd>FloatermNew --name=floatroot --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<root><cr>", desc = "Floating (root dir)" },
      { "<leader>ftF", "<cmd>FloatermNew --name=floatbuffer --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<buffer><cr>", desc = "Floating (cwd)" },
      { "<leader>fts", "<cmd>FloatermNew --name=splitroot --opener=edit --titleposition=center --height=0.35 --wintype=split --cwd=<root><cr>", desc = "Split (root dir)" },
      { "<leader>ftS", "<cmd>FloatermNew --name=splitbuffer --opener=edit --titleposition=center --height=0.35 --wintype=split --cwd=<buffer><cr>", desc = "Split (cwd)" },
    },
		config = function()
			vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
		end,
	},
	{
		"dawsers/telescope-floaterm.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"voldikss/vim-floaterm",
		},
		config = function()
			require("telescope").load_extension("floaterm")
		end,
		keys = {
			{ [[<A-\>]], "<cmd>Telescope floaterm<cr>", desc = "Terminals" },
		},
	},
}

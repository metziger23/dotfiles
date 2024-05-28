local lazygit_config_path = vim.fn.expand("$HOME/.config/lazygit/lazygit-nvim-remote-config.yml")
local lazygit = "lazygit -ucf " .. lazygit_config_path
local float_params = "--opener=edit --titleposition=center --height=0.9 --width=0.9"
local split_params = "--opener=edit --titleposition=center --height=0.35 --wintype=split"

return {
	{
    enabled = false,
		"voldikss/vim-floaterm",
		cmd = { "FloatermNew", "FloatermToggle", "FloatermNext", "FloatermPrev", "FloatermLast", "FloatermFirst" },
    --stylua: ignore
    keys = {
      { "<leader>gg", "<cmd>FloatermNew --name=lazygitroot " .. float_params .. " --cwd=<root> " .. lazygit .. "<CR>", desc = "Lazygit (root dir)" },
      { "<leader>gG", "<cmd>FloatermNew --name=lazygitbuffer " .. float_params .. " --cwd=<buffer> " .. lazygit .. "<CR>", desc = "Lazygit (cwd)" },
      { "<leader>gh", function()
        local git_path = vim.api.nvim_buf_get_name(0)
        vim.api.nvim_command("FloatermNew --name=lazygitroot " .. float_params .. " " .. lazygit .. " -f " .. vim.trim(git_path))
      end, desc = "LazyGit File History (LazyGit)" },
      { "<A-S-l>", "<Esc><Esc><cmd>FloatermNext<CR>", mode = { "t" }, desc = "Next Terminal" },
      { "<A-S-h>", "<Esc><Esc><cmd>FloatermPrev<CR>", mode = { "t" }, desc = "Prev Terminal" },
      { [[<c-\>]], "<cmd>FloatermToggle<cr>", mode = { "n", "t" }, desc = "Toggle Terminal" },
      { "<leader>tf", "<cmd>FloatermNew --name=floatroot " .. float_params .. " --cwd=<root><cr>", desc = "Floaterm Open Floating (root dir)" },
      { "<leader>tF", "<cmd>FloatermNew --name=floatbuffer " .. float_params .. " --cwd=<buffer><cr>", desc = "Floaterm Open Floating (cwd)" },
      { "<leader>ts", "<cmd>FloatermNew --name=splitroot " .. split_params .. " --cwd=<root><cr>", desc = "Floaterm Open Split (root dir)" },
      { "<leader>tS", "<cmd>FloatermNew --name=splitbuffer " .. split_params .. " --cwd=<buffer><cr>", desc = "Floaterm Open Split (cwd)" },
    },
		config = function()
			vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
		end,
	},
	{
    enabled = false,
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

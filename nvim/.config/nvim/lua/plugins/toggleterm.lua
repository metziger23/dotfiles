local lazygit_config_path = vim.fn.expand("$HOME/.config/lazygit/lazygit-nvim-remote-config.yml")
local lazygit_cmd = "lazygit -ucf " .. lazygit_config_path

return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	opts = {
		-- open_mapping = [[<c-\>]],
		-- shade_filetypes = {},
		-- direction = "horizontal",
		-- autochdir = true,
		-- persist_mode = true,
		-- insert_mappings = false,
		-- start_in_insert = true,
    -- persist_size = true,
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		local Terminal = require("toggleterm.terminal").Terminal

		local lazygit = Terminal:new({
			cmd = lazygit_cmd,
			dir = "git_dir",
			-- hidden = true,
			direction = "float",
		})

		vim.keymap.set({ "n", "t", "x" }, "<A-g><A-g>", function()
			lazygit:toggle()
		end, {
			desc = "toggleterm: toggle lazygit",
		})
	end,
}

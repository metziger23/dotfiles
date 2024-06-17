return {
	"stevearc/overseer.nvim",
	dependencies = { "akinsho/toggleterm.nvim" },
	config = function()
		vim.keymap.set({ "n", "t", "x" }, "<A-o>", function() end)
		require("overseer").setup({
			dap = false,
			templates = {},
			strategy = {
				"toggleterm",
				direction = "float",
				hidden = true,
				open_on_start = false,
				on_create = function(term)
					term.on_open = function(_)
						vim.cmd.stopinsert()
						vim.cmd("set number")
					end
					vim.keymap.set({ "n", "t", "x" }, "<A-o>", function()
						term:toggle()
					end, { desc = "toggleterm: toggle overseer" })
				end,
			},
		})
	end,
	keys = {
		{ "<leader>oo", "<cmd>OverseerToggle<CR>", mode = "n", desc = "Overseer Toggle" },
		{ "<leader>or", "<cmd>OverseerRun<CR>", mode = "n", desc = "Overseer Run" },
		{ "<leader>oc", "<cmd>OverseerRunCmd<CR>", mode = "n", desc = "Overseer Run Cmd" },
		{ "<leader>ol", "<cmd>OverseerLoadBundle<CR>", mode = "n", desc = "Overseer Load Bundle" },
		{ "<leader>ob", "<cmd>OverseerToggle! bottom<CR>", mode = "n", desc = "Overseer Toggle Bottom" },
		{ "<leader>od", "<cmd>OverseerQuickAction<CR>", mode = "n", desc = "Overseer Quick Action" },
		{ "<leader>os", "<cmd>OverseerTaskAction<CR>", mode = "n", desc = "Overseer Task Action" },
	},
}

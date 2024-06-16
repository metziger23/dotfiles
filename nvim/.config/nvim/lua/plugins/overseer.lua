return {
	"stevearc/overseer.nvim",
	dependencies = { "akinsho/toggleterm.nvim" },
	config = function()
		require("overseer").setup({
      dap = false,
			templates = { "builtin", "user.run-qmake", "user.make-qmake_all", "user.run-make", "user.run-target" },
			strategy = {
				"toggleterm",
				direction = "float",
				on_create = function(term)
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

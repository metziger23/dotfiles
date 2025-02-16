return {
	"stevearc/overseer.nvim",
	dependencies = { "akinsho/toggleterm.nvim" },
	config = function()
    local toggle_keymap = "<A-r>"
		vim.keymap.set("n", toggle_keymap, function() end)

		local default_components = require("overseer.config").component_aliases.default
		table.insert(default_components, "unique")

		require("overseer").setup({
			component_aliases = { default = default_components },
			dap = false,
			strategy = {
				"toggleterm",
				auto_scroll = false,
				direction = "float",
				hidden = true,
				open_on_start = false,
				on_create = function(term)
					local toggle_desc = "Toggleterm: Toggle Overseer"
					local keymap_opts = { noremap = true, silent = true, desc = toggle_desc }
					term.on_open = function(terminal)
						local on_open_keymap_opts = vim.deepcopy(keymap_opts)
						on_open_keymap_opts.buffer = terminal.bufnr
						vim.keymap.set("t", toggle_keymap, function()
							term:toggle()
						end, on_open_keymap_opts)
						vim.cmd("set number")
					end
					vim.keymap.set("n", toggle_keymap, function()
						term:toggle()
					end, keymap_opts)
				end,
			},
		})

		vim.api.nvim_create_user_command("OverseerRestartLast", function()
			local overseer = require("overseer")
			local tasks = overseer.list_tasks({ recent_first = true })
			if vim.tbl_isempty(tasks) then
				vim.notify("No tasks found", vim.log.levels.WARN)
			else
				overseer.run_action(tasks[1], "restart")
			end
		end, {})
		vim.keymap.set("n", "<A-l>", "<cmd>OverseerRestartLast<CR>", { desc = "Overseer Restart Last Command" })
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

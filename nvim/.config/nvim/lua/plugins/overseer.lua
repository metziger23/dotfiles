return {
	"stevearc/overseer.nvim",
  tag = "v1.6.0",
	dependencies = { "akinsho/toggleterm.nvim", "kkharji/sqlite.lua" },
	config = function()
		local toggle_keymap = "<A-r>"
		vim.keymap.set("n", toggle_keymap, function() end)

		local default_components = require("overseer.config").component_aliases.default
		table.insert(default_components, "unique")

		local overseer = require("overseer")
		overseer.setup({
			component_aliases = { default = default_components },
			dap = false,
			strategy = {
				"toggleterm",
				auto_scroll = false,
				close_on_exit = false,
				quit_on_exit = "never",
				hidden = true,
				direction = "float",
				open_on_start = false,
				on_create = function(term)
					local toggle_desc = "Toggleterm: Toggle Overseer"
					local keymap_opts = { noremap = true, silent = true, desc = toggle_desc }
					term.on_open = function(terminal)
						-- NOTE: not needed since I don't use floating toggleterm
						-- require("../utils/utils").setup_new_tab_breakout_keymap(term.bufnr)
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

		overseer.add_template_hook({ module = "^just$" }, function(task_defn, util)
			util.add_component(task_defn, { "mynamespace.save_to_db" })
		end)

		vim.api.nvim_create_user_command("OverseerRestartLast", function()
			local tasks = require("../utils/overseer_sqlite_tasks")
			local taskName = tasks.getName(vim.fn.getcwd())

			if taskName == nil then
				vim.notify("Last task not found", vim.log.levels.WARN)
				return
			end

			overseer.run_template({ name = taskName, autostart = false }, function(task)
				task.metadata["disable_saving_to_db"] = true
				task:start()
			end)
		end, {})
	end,
	keys = {
		{ "<leader>oo", "<cmd>OverseerToggle<CR>", mode = "n", desc = "Overseer Toggle" },
		{ "<leader>or", "<cmd>OverseerRun<CR>", mode = "n", desc = "Overseer Run" },
		{ "<leader>oc", "<cmd>OverseerRunCmd<CR>", mode = "n", desc = "Overseer Run Cmd" },
		{ "<leader>ol", "<cmd>OverseerLoadBundle<CR>", mode = "n", desc = "Overseer Load Bundle" },
		{ "<leader>ob", "<cmd>OverseerToggle! bottom<CR>", mode = "n", desc = "Overseer Toggle Bottom" },
		{ "<leader>od", "<cmd>OverseerQuickAction<CR>", mode = "n", desc = "Overseer Quick Action" },
		{ "<leader>os", "<cmd>OverseerTaskAction<CR>", mode = "n", desc = "Overseer Task Action" },
		{ "<A-l>", "<cmd>OverseerRestartLast<CR>", mode = "n", desc = "Overseer Restart Last Task" },
	},
}

return {
	"mfussenegger/nvim-dap",
	config = function()
		for _, group in pairs({
			"DapBreakpoint",
			"DapBreakpointCondition",
			"DapBreakpointRejected",
			"DapLogPoint",
		}) do
			vim.fn.sign_define(group, { text = "●", texthl = group })
		end
		vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", numhl = "debugPC" })
	end,
	keys = {
    -- stylua: ignore start
    { '<F1>', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
    { '<F2>', function() require('dap').run_to_cursor() end, desc = 'Run to Cursor' },
    { '<F3>', function() require('dap').goto_() end, desc = 'Go to line (no execute)' },
    { '<F4>', function() require('dap').terminate() end, desc = 'Terminate' },
    { '<F5>', function() require('dap').continue() end, desc = 'Continue' },
    { '<F6>', function() require('dap').pause() end, desc = 'Pause' },
    { '<F7>', function() require('dap').step_into() end, desc = 'Step Into' },
    { '<F8>', function() require('dap').step_out() end, desc = 'Step Out' },
    { '<F9>', function() require('dap').step_over() end, desc = 'Step Over' },
    { '<F10>', function() require('dap').down() end, desc = 'Down' },
    { '<F11>', function() require('dap').up() end, desc = 'Up' },
    { '<F12>', function() require('dap').run_last() end, desc = 'Run Last' },
    { '<F13>', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint Condition' },
    { '<F14>', function() require('dap.ui.widgets').hover() end, desc = 'Widgets' },
    { '<F15>', function() require('dap').repl.toggle() end, desc = 'Toggle REPL' },
    { '<F16>', function() require('dap').session() end, desc = 'Session' },
		-- stylua: ignore end
	},
	opts = function()
		local dap = require("dap")
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb",
				args = {
					"--port",
					"${port}",
					"--settings",
					vim.json.encode({
						showDisassembly = "never",
					}),
				},
			},
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
			{
				name = "Attach to process",
				type = "codelldb",
				request = "attach",
				pid = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.c = dap.configurations.cpp
		require("overseer").enable_dap(true)
	end,
	dependencies = {
		"stevearc/overseer.nvim",
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {
				"nvim-neotest/nvim-nio",
			},
			keys = {
				{
					"<F17>",
					function()
						require("dapui").toggle({})
					end,
					desc = "Dap UI",
				},
				{
					"<F18>",
					function()
						require("dapui").eval()
					end,
					desc = "Eval",
					mode = { "n", "v" },
				},
			},
			opts = {},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({})
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close({})
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close({})
				end
			end,
		},

		-- virtual text for the debugger
		{
			"theHamsta/nvim-dap-virtual-text",
			-- dependencies = 'mfussenegger/nvim-dap',
			opts = {},
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = "mason.nvim",
			cmd = { "DapInstall", "DapUninstall" },
			opts = {
				ensure_installed = { "codelldb" },
			},
		},
	},
}

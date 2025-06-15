return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		presets = {
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		messages = {
			view = "mini", -- default view for messages
			view_error = "mini", -- view for errors
			view_warn = "mini", -- view for warnings
			view_history = "mini", -- view for :messages
			view_search = "mini", -- view for search count messages. Set to `false` to disable
		},
		notify = {
			view = "mini",
		},
		lsp = {
			view = "mini",
			signature = {
				enabled = true,
				auto_open = {
					enabled = false,
				},
			},
		},
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	config = function(_, opts)
		require("noice").setup(opts)
		vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
			if not require("noice.lsp").scroll(4) then
				return "<c-f>"
			end
		end, { silent = true, expr = true })

		vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
			if not require("noice.lsp").scroll(-4) then
				return "<c-b>"
			end
		end, { silent = true, expr = true })

		vim.keymap.set("c", "<S-Enter>", function()
			require("noice").redirect(vim.fn.getcmdline())
		end, { desc = "Redirect Cmdline" })

		-- NOTE: not needed for now since messages are shown in the bottom right corner
		-- vim.keymap.set({ "n", "v", "x", "s", "i", "c", "o", "l" }, "<M-n>", function()
		-- 	require("noice").cmd("dismiss")
		-- end, { desc = "Noice Dismiss" })

		vim.keymap.set("n", "<leader>n", function()
			require("noice").cmd("all")
		end, { desc = "Noice All" })
	end,
}

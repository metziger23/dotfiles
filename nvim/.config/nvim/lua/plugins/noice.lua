return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		presets = {
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		lsp = {
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

		vim.keymap.set({ "n", "v", "x", "s", "i", "c", "o", "l" }, "<M-n>", function()
			require("noice").cmd("dismiss")
		end, { desc = "Noice Dismiss" })
	end,
}

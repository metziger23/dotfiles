return {
	"nemanjamalesija/smart-paste.nvim",
	event = "VeryLazy",
	config = function()
		require("smart-paste").setup()

		local opts = { noremap = true, silent = true }
		opts.desc = "paste charwise content as indented new line below"
		vim.keymap.set("n", "<leader>p", function()
			require("smart-paste").paste({ key = "]p" })
		end, opts)

		opts.desc = "paste charwise content as indented new line above"
		vim.keymap.set("n", "<leader>P", function()
			require("smart-paste").paste({ key = "[p" })
		end, opts)
	end,
}

return {
	"ray-x/lsp_signature.nvim",
  lazy = true,
	opts = {
		doc_lines = 0,
		hint_prefix = "",
    floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)

		vim.keymap.set({"n", "i"}, "<C-s>", function()
			require("lsp_signature").toggle_float_win()
		end, { silent = true, noremap = true, desc = "Toggle Signature" })

	end,
}

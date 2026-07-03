return {
	"metziger23/snacks-fff.nvim",
  enabled = true,
	dependencies = {
		"folke/snacks.nvim",
		{
			"dmtrKovalenko/fff.nvim",
			build = function()
				require("fff.download").download_or_build_binary()
			end,
		},
	},
  config = function ()
    require("snacks-fff").setup()

    vim.keymap.set("n", "<BS>f", function()
      require("snacks-fff").find_files()
    end, { desc = "Smart" })

    vim.keymap.set("n", "<BS><tab>", function()
      require("snacks-fff").find_files()
    end, { desc = "Smart" })

    vim.keymap.set("n", "<BS><leader>", function()
      require("snacks-fff").live_grep({ grep_modes = { "regex", "fuzzy", "plain" } })
    end, { desc = "Live grep" })

  --   vim.keymap.set({ "n", "x" }, "<BS>w", function()
		-- require("snacks-fff").live_grep({
		-- 	query = vim.fn.expand("<cword>"),
		-- 	grep_modes = { "regex", "fuzzy", "plain" },
		-- })
  --   end, { desc = "Live grep" })
  end
}

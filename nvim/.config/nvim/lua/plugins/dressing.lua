return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	config = function()
		require("dressing").setup({
      input = {
        insert_only = false,
      }
    })
	end,
}

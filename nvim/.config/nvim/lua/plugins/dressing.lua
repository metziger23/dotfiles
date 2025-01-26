return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	config = function()
		require("dressing").setup({
      input = {
        insert_only = false,
      },
      select = {
        enabled = false
      }
    })
	end,
}

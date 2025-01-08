local default_toggleterm_opts = {
  direction = "float",
  float_opts = {
    border = "curved",
  },
}

return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	opts = {
    float_opts = {
      border = "curved",
    }
  },
	config = function(_, opts)
		require("toggleterm").setup(opts)
		local modes = { "n", "t", "x" }
		local Terminal = require("toggleterm.terminal").Terminal
    local default_toggleterm = Terminal:new(vim.deepcopy(default_toggleterm_opts))

    vim.keymap.set(modes, "<M-C-t>", function ()
      default_toggleterm:toggle()
    end, { desc = "Toggle default Toggleterm" })
	end,
}

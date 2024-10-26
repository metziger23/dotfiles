return {
	"sindrets/diffview.nvim", -- optional - Diff integration
  dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = {
		"DiffviewClose",
		"DiffviewLog",
		"DiffviewOpen",
		"DiffviewRefresh",
		"DiffviewFocusFiles",
		"DiffviewFileHistory",
		"DiffviewToggleFiles",
	},
  config = function ()
    require("diffview").setup({})
    vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
      pattern = "diffview:///panels/*",
      callback = function()
        if vim.api.nvim_win_get_config(0).zindex then
          vim.api.nvim_win_set_config(0, { border = "rounded" })
        end
      end,
    })
  end
}

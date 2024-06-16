return {
	"metziger23/exrc.nvim",
  config = function ()
    require("exrc").setup({
      exrc_name = '.tasks.lua', -- Name of exrc files to use
      min_log_level = vim.log.levels.INFO, -- Disable notifications below this level (TRACE=most logs)
    })
  end
}

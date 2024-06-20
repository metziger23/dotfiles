return {
	"jedrzejboczar/exrc.nvim",
	config = function ()
    require("exrc").setup({
      exrc_name = '.tasks.lua', -- Name of exrc files to use
      on_dir_changed = { -- Automatically load exrc files on DirChanged autocmd
        enabled = true,
        -- Wait until CursorHold and use vim.ui.select to confirm files to load, instead of loading unconditionally
        use_ui_select = false,
      },
      min_log_level = vim.log.levels.INFO, -- Disable notifications below this level (TRACE=most logs)
    })
	end
}

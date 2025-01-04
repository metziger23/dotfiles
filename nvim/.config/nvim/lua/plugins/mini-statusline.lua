local symbols = {
	["CANCELED"] = " ",
	["FAILURE"] = "󰅚 ",
	["SUCCESS"] = "󰄴 ",
	["RUNNING"] = "󰑮 ",
}

local function overseer_task_status(status)
	if not package.loaded.overseer then
		return nil
	end
	local tasks = require("overseer.task_list").list_tasks({ unique = true })
	local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
	if not tasks_by_status[status] then
		return nil
	end
	return string.format("%s%d", symbols[status], #tasks_by_status[status])
end

local function overseer_task_status_hl(string, hl)
  if string == nil then
    return "MiniStatuslineInactive"
  end
  return hl
end

local function get_cwd()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
end

local function get_relative_filename()
  return vim.fn.expand("%:.")
end

return {
	"echasnovski/mini.statusline",
	version = "*",
	config = function()
		local MiniStatusline = require("mini.statusline")
		MiniStatusline.setup({
			content = {
				-- Content for active window
				active = function()
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
					local git = MiniStatusline.section_git({ trunc_width = 40 })
					local diff = MiniStatusline.section_diff({ trunc_width = 75 })
					local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
					local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
---@diagnostic disable-next-line: unused-local
					local filename = MiniStatusline.section_filename({ trunc_width = 140 })
					local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
					local location = MiniStatusline.section_location({ trunc_width = 75 })
					local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
          local overseer_canceled = overseer_task_status("CANCELED")
          local overseer_failure = overseer_task_status("FAILURE")
          local overseer_success = overseer_task_status("SUCCESS")
          local overseer_running = overseer_task_status("RUNNING")

					return MiniStatusline.combine_groups({
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
						"%<", -- Mark general truncate point
            { hl = overseer_task_status_hl(overseer_canceled, "markdownH3"), strings = { overseer_canceled } },
            { hl = overseer_task_status_hl(overseer_failure, "markdownH1"), strings = { overseer_failure } },
            { hl = overseer_task_status_hl(overseer_success, "markdownH4"), strings = { overseer_success } },
            { hl = overseer_task_status_hl(overseer_running, "markdownH2"), strings = { overseer_running } },
						{ hl = "MiniStatuslineFilename", strings = { get_relative_filename() } },

						"%=", -- End left alignment
            { hl = "MiniStatuslineFilename", strings = { get_cwd() } },
						{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
						{ hl = mode_hl, strings = { search, location } },
					})
				end,
			},
		})
	end,
}

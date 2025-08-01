-- NOTE: taken from fzf-lua code
local function change_dir(selected, opts, cmd)
  local uv = vim.uv or vim.loop
  local utils = require "fzf-lua.utils"
  local path = require "fzf-lua.path"

  if #selected == 0 then return end
  local cwd = selected[1]:match("[^\t]+$") or selected[1]
  if opts.cwd then
    cwd = path.join({ opts.cwd, cwd })
  end
  local git_root = opts.git_root and path.git_root({ cwd = cwd }, true) or nil
  cwd = git_root or cwd
  if uv.fs_stat(cwd) then
    vim.cmd(cmd .. " " .. cwd)
    utils.io_system({ "zoxide", "add", "--", cwd })
    utils.info(("cwd set to %s'%s'"):format(git_root and "git root " or "", cwd))
  else
    utils.warn(("Unable to set cwd to '%s', directory is not accessible"):format(cwd))
  end
end

local function cd(selected, opts)
  return change_dir(selected, opts, "cd")
end

local function lcd(selected, opts)
  return change_dir(selected, opts, "lcd")
end

local function tcd(selected, opts)
  return change_dir(selected, opts, "tcd")
end

return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	opts = {
		oldfiles = {
			include_current_session = true,
		},
		grep = {
			rg_glob = true,
		},
		fzf_opts = {
			["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
		},
		winopts = {
			preview = {
				layout = "vertical",
				vertical = "up",
			},
		},
	},
  -- stylua: ignore
  keys = {
    { "<BS>b", function() require("fzf-lua").buffers() end, desc = "Fzf buffers", mode = { "n", "x" } },
    { "<BS>f", function() require("fzf-lua").files() end, desc = "Fzf files", mode = { "n", "x" } },
    { "<BS>o", function() require("fzf-lua").oldfiles() end, desc = "Fzf oldfiles", mode = { "n", "x" } },
    { "<BS>q", function() require("fzf-lua").quickfix() end, desc = "Fzf quickfix", mode = { "n", "x" } },
    { "<BS>Q", function() require("fzf-lua").quickfix_stack() end, desc = "Fzf quickfix stack", mode = { "n", "x" } },
    { "<BS>l", function() require("fzf-lua").loclist() end, desc = "Fzf loclist", mode = { "n", "x" } },
    { "<BS>L", function() require("fzf-lua").loclist_stack() end, desc = "Fzf loclist stack", mode = { "n", "x" } },
    { "<BS>t", function() require("fzf-lua").treesitter() end, desc = "Fzf current buffer treesitter symbols", mode = { "n", "x" } },
    { "<BS>a", function() require("fzf-lua").args() end, desc = "Fzf argument list", mode = { "n", "x" } },
    { "<BS>,", function() require("fzf-lua").blines() end, desc = "Fzf current buffer lines", mode = { "n", "x" } },
    { "<BS>.", function() require("fzf-lua").lines() end, desc = "Fzf open buffers lines", mode = { "n", "x" } },

    { "<BS>w", function() require("fzf-lua").grep_cword() end, desc = "Fzf search word under cursor", mode = { "n", "x" } },
    { "<BS>W", function() require("fzf-lua").grep_cWORD() end, desc = "Fzf search WORD under cursor", mode = { "n", "x" } },
    { "<BS><leader>", function() require("fzf-lua").grep_visual() end, desc = "Fzf search visual selection", mode = "x" },
    { "<BS><leader>", function() require("fzf-lua").live_grep() end, desc = "Fzf live grep current project" },

    { "<BS>r", function() require("fzf-lua").resume() end, desc = "Fzf resume last command/query", mode = { "n", "x" } },
    { "<BS>B", function() require("fzf-lua").builtin() end, desc = "Fzf builtin commands", mode = { "n", "x" } },
    { "<BS>p", function() require("fzf-lua").helptags() end, desc = "Fzf help tags", mode = { "n", "x" } },
    { "<BS>M", function() require("fzf-lua").manpages() end, desc = "Fzf man pages", mode = { "n", "x" } },
    { "<BS>c", function() require("fzf-lua").commands() end, desc = "Fzf neovim commands", mode = { "n", "x" } },
    { "<BS>h", function() require("fzf-lua").command_history() end, desc = "Fzf command history", mode = { "n", "x" } },
    { "<BS>s", function() require("fzf-lua").search_history() end, desc = "Fzf search history", mode = { "n", "x" } },
    { "<BS>m", function() require("fzf-lua").marks() end, desc = "Fzf marks", mode = { "n", "x" } },
    { "<BS>j", function() require("fzf-lua").jumps() end, desc = "Fzf jumps", mode = { "n", "x" } },
    { "<BS>C", function() require("fzf-lua").changes() end, desc = "Fzf changes", mode = { "n", "x" } },
    { "<BS>R", function() require("fzf-lua").registers() end, desc = "Fzf registers", mode = { "n", "x" } },
    { "<BS>A", function() require("fzf-lua").autocmds() end, desc = "Fzf autocommands", mode = { "n", "x" } },
    { "<BS>k", function() require("fzf-lua").keymaps() end, desc = "Fzf keymaps", mode = { "n", "x" } },
    { "<BS>F", function() require("fzf-lua").filetypes() end, desc = "Fzf filetypes", mode = { "n", "x" } },
    { "<BS>S", function() require("fzf-lua").spell_suggest() end, desc = "Fzf spelling suggestions", mode = { "n", "x" } },
    { "<BS>O", function() require("fzf-lua").nvim_options() end, desc = "Fzf nvim options", mode = { "n", "x" } },

    { "<BS>gf", function() require("fzf-lua").git_files() end, desc = "Fzf git files", mode = { "n", "x" } },
    { "<BS>gs", function() require("fzf-lua").git_status() end, desc = "Fzf git status", mode = { "n", "x" } },
    { "<BS>gi", function() require("fzf-lua").git_diff() end, desc = "Fzf git diff", mode = { "n", "x" } },
    { "<BS>gh", function() require("fzf-lua").git_hunks() end, desc = "Fzf git hunks", mode = { "n", "x" } },
    { "<BS>gc", function() require("fzf-lua").git_commits() end, desc = "Fzf git commit log (current project)", mode = { "n", "x" } },
    { "<BS>gn", function() require("fzf-lua").git_bcommits() end, desc = "Fzf git commit log (current buffer)", mode = { "n", "x" } },
    { "<BS>ga", function() require("fzf-lua").git_blame() end, desc = "Fzf git blame (buffer)", mode = { "n", "x" } },
    { "<BS>gr", function() require("fzf-lua").git_branches() end, desc = "Fzf git branches", mode = { "n", "x" } },
    { "<BS>gt", function() require("fzf-lua").git_tags() end, desc = "Fzf git tags", mode = { "n", "x" } },
    { "<BS>ge", function() require("fzf-lua").git_stash() end, desc = "Fzf git stash", mode = { "n", "x" } },

    {
      "<BS>zc", function()
        require("fzf-lua").zoxide({ actions = { enter = cd } })
      end, desc = "Fzf zoxide cd",
    },
    {
      "<BS>zl", function()
        require("fzf-lua").zoxide({ actions = { enter = lcd } })
      end, desc = "Fzf zoxide lcd",
    },
    {
      "<BS>zt", function()
        require("fzf-lua").zoxide({ actions = { enter = tcd } })
      end, desc = "Fzf zoxide tcd",
    }
  },
	init = function()
		require("fzf-lua").register_ui_select(function(_, items)
			local min_h, max_h = 0.15, 0.70
			local h = (#items + 4) / vim.o.lines
			if h < min_h then
				h = min_h
			elseif h > max_h then
				h = max_h
			end
			return { winopts = { height = h, width = 0.60, row = 0.40 } }
		end)
	end,
}

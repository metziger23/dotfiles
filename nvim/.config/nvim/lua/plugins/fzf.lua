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
    { "<BS>b", function() require("fzf-lua").buffers() end, desc = "Fzf buffers" },
    { "<BS>f", function() require("fzf-lua").files() end, desc = "Fzf files" },
    { "<BS>o", function() require("fzf-lua").oldfiles() end, desc = "Fzf oldfiles" },
    { "<BS>q", function() require("fzf-lua").quickfix() end, desc = "Fzf quickfix" },
    { "<BS>Q", function() require("fzf-lua").quickfix_stack() end, desc = "Fzf quickfix stack" },
    { "<BS>l", function() require("fzf-lua").loclist() end, desc = "Fzf loclist" },
    { "<BS>L", function() require("fzf-lua").loclist_stack() end, desc = "Fzf loclist stack" },
    { "<BS>t", function() require("fzf-lua").treesitter() end, desc = "Fzf current buffer treesitter symbols" },
    { "<BS>a", function() require("fzf-lua").args() end, desc = "Fzf argument list" },
    { "<BS>,", function() require("fzf-lua").blines() end, desc = "Fzf current buffer lines" },
    { "<BS>.", function() require("fzf-lua").lines() end, desc = "Fzf open buffers lines" },

    { "<BS>w", function() require("fzf-lua").grep_cword() end, desc = "Fzf search word under cursor" },
    { "<BS>W", function() require("fzf-lua").grep_cWORD() end, desc = "Fzf search WORD under cursor" },
    { "<BS><leader>", function() require("fzf-lua").grep_visual() end, desc = "Fzf search visual selection", mode = "v" },
    { "<BS><leader>", function() require("fzf-lua").live_grep() end, desc = "Fzf live grep current project" },

    { "<BS>r", function() require("fzf-lua").resume() end, desc = "Fzf resume last command/query" },
    { "<BS>B", function() require("fzf-lua").builtin() end, desc = "Fzf builtin commands" },
    { "<BS>p", function() require("fzf-lua").helptags() end, desc = "Fzf help tags" },
    { "<BS>M", function() require("fzf-lua").manpages() end, desc = "Fzf man pages" },
    { "<BS>c", function() require("fzf-lua").commands() end, desc = "Fzf neovim commands" },
    { "<BS>h", function() require("fzf-lua").command_history() end, desc = "Fzf command history" },
    { "<BS>s", function() require("fzf-lua").search_history() end, desc = "Fzf search history" },
    { "<BS>m", function() require("fzf-lua").marks() end, desc = "Fzf marks" },
    { "<BS>j", function() require("fzf-lua").jumps() end, desc = "Fzf jumps" },
    { "<BS>C", function() require("fzf-lua").changes() end, desc = "Fzf changes" },
    { "<BS>R", function() require("fzf-lua").registers() end, desc = "Fzf registers" },
    { "<BS>A", function() require("fzf-lua").autocmds() end, desc = "Fzf autocommands" },
    { "<BS>k", function() require("fzf-lua").keymaps() end, desc = "Fzf keymaps" },
    { "<BS>F", function() require("fzf-lua").filetypes() end, desc = "Fzf filetypes" },
    { "<BS>S", function() require("fzf-lua").spell_suggest() end, desc = "Fzf spelling suggestions" },
    { "<BS>O", function() require("fzf-lua").nvim_options() end, desc = "Fzf nvim options" },

    { "<BS>gf", function() require("fzf-lua").git_files() end, desc = "Fzf git files" },
    { "<BS>gs", function() require("fzf-lua").git_status() end, desc = "Fzf git status" },
    { "<BS>gi", function() require("fzf-lua").git_diff() end, desc = "Fzf git diff" },
    { "<BS>gh", function() require("fzf-lua").git_hunks() end, desc = "Fzf git hunks" },
    { "<BS>gc", function() require("fzf-lua").git_commits() end, desc = "Fzf git commit log (current project)" },
    { "<BS>gn", function() require("fzf-lua").git_bcommits() end, desc = "Fzf git commit log (current buffer)" },
    { "<BS>ga", function() require("fzf-lua").git_blame() end, desc = "Fzf git blame (buffer)" },
    { "<BS>gr", function() require("fzf-lua").git_branches() end, desc = "Fzf git branches" },
    { "<BS>gt", function() require("fzf-lua").git_tags() end, desc = "Fzf git tags" },
    { "<BS>ge", function() require("fzf-lua").git_stash() end, desc = "Fzf git stash" },

    {
      "<BS>zc", function()
        require("fzf-lua").zoxide({ actions = { enter = require("fzf-lua").actions.cd } })
      end, desc = "Fzf zoxide cd",
    },
    {
      "<BS>zl", function()
        require("fzf-lua").zoxide({ actions = { enter = require("fzf-lua").actions.lcd } })
      end, desc = "Fzf zoxide lcd",
    },
    {
      "<BS>zt", function()
        require("fzf-lua").zoxide({ actions = { enter = require("fzf-lua").actions.tcd } })
      end, desc = "Fzf zoxide tcd",
    }
  },
	-- init = function()
	-- 	require("fzf-lua").register_ui_select(function(_, items)
	-- 		local min_h, max_h = 0.15, 0.70
	-- 		local h = (#items + 4) / vim.o.lines
	-- 		if h < min_h then
	-- 			h = min_h
	-- 		elseif h > max_h then
	-- 			h = max_h
	-- 		end
	-- 		return { winopts = { height = h, width = 0.60, row = 0.40 } }
	-- 	end)
	-- end,
}

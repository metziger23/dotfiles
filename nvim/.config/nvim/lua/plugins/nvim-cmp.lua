return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"hrsh7th/cmp-cmdline",
    "chrisgrieser/cmp_yanky",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

    local check_backspace = function()
      local col = vim.fn.col "." - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
    end

    local format_fn = function(_, item)
          item.menu = ""
          local fixed_width = 40
          local content = item.abbr

      if fixed_width then
        vim.o.pumwidth = fixed_width
      end

      local win_width = vim.api.nvim_win_get_width(0)

      local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

      if #content > max_content_width then
        item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
      else
        item.abbr = content .. (" "):rep(max_content_width - #content)
      end

      return item
    end

    local cmdline_up = function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp.complete()
      end
    end

    local cmdline_down = function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end

    local mapping_preset_cmdline = cmp.mapping.preset.cmdline({
      ['<Up>'] = { c = cmdline_up },
      ['<Down>'] = { c = cmdline_down },
    })

		-- `/` cmdline setup.
		cmp.setup.cmdline("/", {
			mapping = mapping_preset_cmdline,
			sources = {
				{ name = "buffer" },
			},
		})

		-- `?` cmdline setup.
		cmp.setup.cmdline("?", {
			mapping = mapping_preset_cmdline,
			sources = {
				{ name = "buffer" },
			},
		})


		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = mapping_preset_cmdline,
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
        ["<Up>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<Down>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, {
            "i",
            "s",
          }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
            "i",
            "s",
          }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
        { name = "cmp_yanky", option = { minLength = 1 } }
			}),

      formatting = {
        fields = { "abbr", "kind" },
        format = lspkind.cmp_format({
          maxwidth = 40,
          ellipsis_char = "...",
          before = format_fn,
        }),
      },
		})
	end,
}

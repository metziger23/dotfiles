return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},
	config = function()

    local check_backspace = function()
      local col = vim.fn.col "." - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
    end
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- `/` cmdline setup.
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
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
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
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
        { name = 'nvim_lsp_signature_help' }
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
      -- https://github.com/hrsh7th/nvim-cmp/discussions/609#discussioncomment-5727678
      formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(entry, item)
          -- Define menu shorthand for different completion sources.
          local menu_icon = {
            nvim_lsp = "NLSP",
            nvim_lua = "NLUA",
            luasnip  = "LSNP",
            buffer   = "BUFF",
            path     = "PATH",
          }
          -- Set the menu "icon" to the shorthand for each completion source.
          item.menu = menu_icon[entry.source.name]

          -- Set the fixed width of the completion menu to 60 characters.
          -- fixed_width = 20

          -- Set 'fixed_width' to false if not provided.
          local fixed_width = fixed_width or false

          -- Get the completion entry text shown in the completion window.
          local content = item.abbr

          -- Set the fixed completion window width.
          if fixed_width then
            vim.o.pumwidth = fixed_width
          end

          -- Get the width of the current window.
          local win_width = vim.api.nvim_win_get_width(0)

          -- Set the max content width based on either: 'fixed_width'
          -- or a percentage of the window width, in this case 20%.
          -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
          local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

          -- Truncate the completion entry text if it's longer than the
          -- max content width. We subtract 3 from the max content width
          -- to account for the "..." that will be appended to it.
          if #content > max_content_width then
            item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
          else
            item.abbr = content .. (" "):rep(max_content_width - #content)
          end
          return item
        end,
      },
		})
	end,
}

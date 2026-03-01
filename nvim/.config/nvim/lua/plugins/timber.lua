-- stylua: ignore start
local colors = {
  "red", "green", "blue", "orange", "purple", "teal", "pink", "lime",
  "white", "navy", "olive", "silver", "gray", "gold", "cyan", "magenta",
  "brown", "darkgreen", "skyblue", "indigo", "coral", "yellow", "violet", "firebrick",
  "royalblue", "sienna", "tomato", "slateblue",
  "lightgrey", "lavenderblush", "deeppink", "seashell",
  "lightsalmon", "lightgreen", "deepskyblue", "mistyrose",
  "dimgray", "navajowhite", "peru", "darkgrey",
  "steelblue", "orangered", "mediumslateblue", "blueviolet",
  "cornflowerblue", "beige", "goldenrod", "rosybrown",
  "darkblue", "aliceblue", "mediumblue", "dodgerblue",
  "limegreen", "lightsteelblue", "lightslategray", "seagreen",
  "mediumvioletred", "slategrey", "darkslategrey", "turquoise",
  "paleturquoise", "lightgoldenrodyellow", "darkseagreen", "lightcyan",
  "lightcoral", "mediumseagreen", "palegoldenrod", "palegreen",
  "darkslateblue", "moccasin", "forestgreen", "darkkhaki",
  "chartreuse", "floralwhite", "snow", "fuchsia",
  "orchid", "darkorchid", "darkred", "darksalmon",
  "crimson", "palevioletred", "lightseagreen", "ivory",
  "powderblue", "aquamarine", "darkturquoise", "lavender",
  "azure", "mediumturquoise", "lightgray", "transparent",
  "gainsboro", "olivedrab", "papayawhip", "midnightblue",
  "yellowgreen", "slategray", "grey", "wheat",
  "darkgoldenrod", "lawngreen", "lightslategrey", "burlywood",
  "aqua", "saddlebrown", "oldlace", "lightskyblue",
  "dimgrey", "darkorange", "lightblue", "khaki",
  "mediumpurple", "linen", "mediumorchid", "indianred",
  "maroon", "darkgray", "hotpink", "cadetblue",
  "darkslategray", "plum", "mediumspringgreen", "thistle",
  "mintcream", "darkmagenta", "lemonchiffon", "bisque",
  "antiquewhite", "whitesmoke", "lightpink", "darkcyan",
  "tan", "blanchedalmond", "honeydew", "salmon",
  "lightyellow", "springgreen", "cornsilk", "sandybrown",
  "mediumaquamarine", "darkviolet", "darkolivegreen", "peachpuff",
  "greenyellow", "ghostwhite", "chocolate",
}
-- stylua: ignore end

local search_helper_tag = "N1ZpIq"

return {
	"metziger23/timber.nvim",
	branch = "colored_tag",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("timber").setup({
      -- stylua: ignore start
      log_templates = {
        default = {
          -- Templates with auto_import: when inserting a log statement, the import line is inserted automatically
          -- Applies to batch log statements as well
          -- javascript = {
          --   [[logger.info('hello world')]],
          --   auto_import = [[const logger = require('pino')()]]
          -- }
          javascript = [[console.log("%tag %log_target", %log_target)]],
          typescript = [[console.log("%tag %log_target", %log_target)]],
          astro =      [[console.log("%tag %log_target", %log_target)]],
          vue =        [[console.log("%tag %log_target", %log_target)]],
          jsx =        [[console.log("%tag %log_target", %log_target)]],
          tsx =        [[console.log("%tag %log_target", %log_target)]],
          lua =        [[print("%tag %log_target", %log_target)]],
          luau =       [[print("%tag %log_target", %log_target)]],
          ruby =       [[puts("%log_target #{%log_target}")]],
          elixir =     [[IO.inspect(%log_target, label: "%log_target")]],
          go =         [[log.Printf("%log_target: %v\n", %log_target)]],
          rust =       [[println!("%log_target: {:#?}", %log_target);]],
          python =     [[print(f"{%log_target=}")]],
          c =          [[printf("%tag %log_target: %s\n", %log_target);]],
          cpp =        [[qDebug() << "%tag %log_target: " << %log_target;]],
          java =       [[System.out.println("%log_target: " + %log_target);]],
          c_sharp =    [[Console.WriteLine($"%log_target: {%log_target}");]],
          odin =       [[fmt.printfln("%log_target: %v", %log_target)]],
          bash =       [[echo "%tag %log_target: ${%log_target}"]],
          swift =      [[print("%log_target:", %log_target)]],
          kotlin =     [[println("%log_target: ${%log_target}")]],

          qml =        [[console.log("%tag %log_target", %log_target)]],
          qmljs =      [[console.log("%tag %log_target", %log_target)]],
        },
        plain = {
          javascript = [[console.log("%tag %insert_cursor")]],
          typescript = [[console.log("%tag %insert_cursor")]],
          astro =      [[console.log("%tag %insert_cursor")]],
          vue =        [[console.log("%tag %insert_cursor")]],
          jsx =        [[console.log("%tag %insert_cursor")]],
          tsx =        [[console.log("%tag %insert_cursor")]],
          lua =        [[print("%tag %insert_cursor")]],
          luau =       [[print("%tag %insert_cursor")]],
          ruby =       [[puts("%insert_cursor")]],
          elixir =     [[IO.puts(%insert_cursor)]],
          go =         [[log.Println("%insert_cursor")]],
          rust =       [[println!("%insert_cursor");]],
          python =     [[print(f"%insert_cursor")]],
          c =          [[printf("%tag %insert_cursor \n");]],
          cpp =        [[qDebug() << "%tag %insert_cursor";]],
          java =       [[System.out.println("%insert_cursor");]],
          c_sharp =    [[Console.WriteLine("%insert_cursor");]],
          odin =       [[fmt.println("%insert_cursor")]],
          bash =       [[echo "%tag %insert_cursor"]],
          swift =      [[print("%insert_cursor")]],
          kotlin =     [[println("%insert_cursor")]],

          qml =        [[console.log("%tag %insert_cursor")]],
          qmljs =      [[console.log("%tag %insert_cursor")]],
        },
        line_text = {
          javascript = [[console.log("%tag %line_text")]],
          typescript = [[console.log("%tag %line_text")]],
          astro =      [[console.log("%tag %line_text")]],
          vue =        [[console.log("%tag %line_text")]],
          jsx =        [[console.log("%tag %line_text")]],
          tsx =        [[console.log("%tag %line_text")]],
          lua =        [[print("%tag %line_text")]],
          luau =       [[print("%tag %line_text")]],
          ruby =       [[puts("%tag %line_text")]],
          elixir =     [[IO.puts(%tag %line_text)]],
          go =         [[log.Println("%tag %line_text")]],
          rust =       [[println!("%tag %line_text");]],
          python =     [[print(f"%tag %line_text")]],
          c =          [[printf("%tag %line_text \n");]],
          cpp =        [[qDebug() << "%tag %line_text";]],
          java =       [[System.out.println("%tag %line_text");]],
          c_sharp =    [[Console.WriteLine("%tag %line_text");]],
          odin =       [[fmt.println("%tag %line_text")]],
          bash =       [[echo "%tag %line_text"]],
          swift =      [[print("%tag %line_text")]],
          kotlin =     [[println("%tag %line_text")]],

          qml =        [[console.log("%tag %line_text")]],
          qmljs =      [[console.log("%tag %line_text")]],
        }
      },
      batch_log_templates = {
        default = {
          javascript = [[console.log({ %repeat<"%tag %log_target": %log_target><, > })]],
          typescript = [[console.log({ %repeat<"%tag %log_target": %log_target><, > })]],
          astro =      [[console.log({ %repeat<"%tag %log_target": %log_target><, > })]],
          vue =        [[console.log({ %repeat<"%tag %log_target": %log_target><, > })]],
          jsx =        [[console.log({ %repeat<"%tag %log_target": %log_target><, > })]],
          tsx =        [[console.log({ %repeat<"%tag %log_target": %log_target><, > })]],
          lua =        [[print(string.format("%repeat<%log_target=%s><, >", %repeat<%log_target><, >))]],
          luau =       [[print(`%repeat<%log_target={%log_target}><, >`)]],
          ruby =       [[puts("%repeat<%log_target: #{%log_target}><, >")]],
          elixir =     [[IO.inspect({ %repeat<%log_target><, > })]],
          go =         [[log.Printf("%repeat<%log_target: %v><, >\n", %repeat<%log_target><, >)]],
          rust =       [[println!("%repeat<%log_target: {:#?}><, >", %repeat<%log_target><, >);]],
          python =     [[print(f"%repeat<{%log_target=}><, >")]],
          c =          [[printf("%repeat<%log_target: %s><, >\n", %repeat<%log_target><, >);]],
          cpp =        [[qDebug() %repeat<<< "%tag %log_target: " << %log_target>< << "\n  " >;]],
          java =       [[System.out.printf("%repeat<%log_target=%s><, >%n", %repeat<%log_target><, >);]],
          c_sharp =    [[Console.WriteLine($"%repeat<%log_target: {%log_target}><, >");]],
          odin =       [[fmt.printfln("%repeat<%log_target: %v><, >", %repeat<%log_target><, >)]],
          bash =       [[echo "%repeat<%log_target: ${%log_target}><, >"]],
          swift =      [[print("%repeat<%log_target: %log_target><, >")]],
          kotlin =     [[println("%repeat<%log_target=${%log_target}><, >")]],

          qml =        [[console.log({ %repeat<"%tag %log_target": %log_target><, > })]],
          qmljs =      [[console.log({ %repeat<"%tag %log_target": %log_target><, > })]],
        },
      },
			-- stylua: ignore end
			template_placeholders = {
				tag = function(ctx)
					if vim.g.TIMBER_COLORED_TAG == nil or vim.g.TIMBER_COLORED_TAG > 1000000 then
						vim.g.TIMBER_COLORED_TAG = 0
					end

					vim.g.TIMBER_COLORED_TAG = vim.g.TIMBER_COLORED_TAG + 1

					local color_number = math.fmod(vim.g.TIMBER_COLORED_TAG, #colors)
					local color = colors[color_number]

					vim.cmd("wshada")

					return string.format(search_helper_tag .. " " .. color .. ": %s", ctx.log_position)
				end,
				line_text = function(_)
					return vim.trim(vim.fn.getline(".")):gsub('"', ""):sub(1, 50)
				end,
			},
		})

		vim.keymap.set({ "n", "v" }, "gls", function()
			return require("timber.actions").insert_log({ template = "line_text", position = "below" })
		end, { desc = "Log current line below" })

		vim.keymap.set({ "n", "v" }, "glr", function()
			return require("timber.actions").insert_log({ template = "line_text", position = "above" })
		end, { desc = "Log current line above" })

		vim.keymap.set({ "n", "v" }, "gle", function()
			require("timber.actions").insert_log({ position = "below" })
		end, { desc = "Insert log statement below" })

		vim.keymap.set({ "n", "v" }, "gli", function()
			require("timber.actions").insert_log({ position = "above" })
		end, { desc = "Insert log statement above" })

    vim.keymap.set("n", "glt", function()
		return require("timber.actions").insert_log({ position = "below", operator = true })
    end, { expr = true, desc = "Insert log below operator"  })

    vim.keymap.set("n", "gla", function()
      return require("timber.actions").insert_log({ position = "above", operator = true })
    end, { expr = true, desc = "Insert log above operator"  })

    vim.fn.setreg("n", search_helper_tag)
	end,
}

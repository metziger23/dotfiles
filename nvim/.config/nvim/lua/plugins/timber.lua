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

return {
	"metziger23/timber.nvim",
  branch = "colored_tag",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("timber").setup({
      log_templates = {
        default = {
          -- Templates with auto_import: when inserting a log statement, the import line is inserted automatically
          -- Applies to batch log statements as well
          -- javascript = {
          --   [[logger.info('hello world')]],
          --   auto_import = [[const logger = require('pino')()]]
          -- }
          javascript = [[console.log("%log_target", %log_target)]],
          typescript = [[console.log("%log_target", %log_target)]],
          astro =      [[console.log("%log_target", %log_target)]],
          vue =        [[console.log("%log_target", %log_target)]],
          jsx =        [[console.log("%log_target", %log_target)]],
          tsx =        [[console.log("%log_target", %log_target)]],
          lua =        [[print("%log_target", %log_target)]],
          luau =       [[print("%log_target", %log_target)]],
          ruby =       [[puts("%log_target #{%log_target}")]],
          elixir =     [[IO.inspect(%log_target, label: "%log_target")]],
          go =         [[log.Printf("%log_target: %v\n", %log_target)]],
          rust =       [[println!("%log_target: {:#?}", %log_target);]],
          python =     [[print(f"{%log_target=}")]],
          c =          [[printf("%log_target: %s\n", %log_target);]],
          cpp =        [[std::cout << "%tag %log_target: " << %log_target << std::endl;]],
          java =       [[System.out.println("%log_target: " + %log_target);]],
          c_sharp =    [[Console.WriteLine($"%log_target: {%log_target}");]],
          odin =       [[fmt.printfln("%log_target: %v", %log_target)]],
          bash =       [[echo "%log_target: ${%log_target}"]],
          swift =      [[print("%log_target:", %log_target)]],
          kotlin =     [[println("%log_target: ${%log_target}")]],

          qml =        [[console.log("%log_target", %log_target)]],
          qmljs =      [[console.log("%log_target", %log_target)]],
        },
        plain = {
          javascript = [[console.log("%insert_cursor")]],
          typescript = [[console.log("%insert_cursor")]],
          astro =      [[console.log("%insert_cursor")]],
          vue =        [[console.log("%insert_cursor")]],
          jsx =        [[console.log("%insert_cursor")]],
          tsx =        [[console.log("%insert_cursor")]],
          lua =        [[print("%insert_cursor")]],
          luau =       [[print("%insert_cursor")]],
          ruby =       [[puts("%insert_cursor")]],
          elixir =     [[IO.puts(%insert_cursor)]],
          go =         [[log.Println("%insert_cursor")]],
          rust =       [[println!("%insert_cursor");]],
          python =     [[print(f"%insert_cursor")]],
          c =          [[printf("%insert_cursor \n");]],
          cpp =        [[std::cout << "%insert_cursor" << std::endl;]],
          java =       [[System.out.println("%insert_cursor");]],
          c_sharp =    [[Console.WriteLine("%insert_cursor");]],
          odin =       [[fmt.println("%insert_cursor")]],
          bash =       [[echo "%insert_cursor"]],
          swift =      [[print("%insert_cursor")]],
          kotlin =     [[println("%insert_cursor")]],

          qml =        [[console.log("%insert_cursor")]],
          qmljs =      [[console.log("%insert_cursor")]],
        },
      },
      batch_log_templates = {
        default = {
          javascript = [[console.log({ %repeat<"%log_target": %log_target><, > })]],
          typescript = [[console.log({ %repeat<"%log_target": %log_target><, > })]],
          astro =      [[console.log({ %repeat<"%log_target": %log_target><, > })]],
          vue =        [[console.log({ %repeat<"%log_target": %log_target><, > })]],
          jsx =        [[console.log({ %repeat<"%log_target": %log_target><, > })]],
          tsx =        [[console.log({ %repeat<"%log_target": %log_target><, > })]],
          lua =        [[print(string.format("%repeat<%log_target=%s><, >", %repeat<%log_target><, >))]],
          luau =       [[print(`%repeat<%log_target={%log_target}><, >`)]],
          ruby =       [[puts("%repeat<%log_target: #{%log_target}><, >")]],
          elixir =     [[IO.inspect({ %repeat<%log_target><, > })]],
          go =         [[log.Printf("%repeat<%log_target: %v><, >\n", %repeat<%log_target><, >)]],
          rust =       [[println!("%repeat<%log_target: {:#?}><, >", %repeat<%log_target><, >);]],
          python =     [[print(f"%repeat<{%log_target=}><, >")]],
          c =          [[printf("%repeat<%log_target: %s><, >\n", %repeat<%log_target><, >);]],
          cpp =        [[std::cout %repeat<<< "%log_target: " << %log_target>< << "\n  " > << std::endl;]],
          java =       [[System.out.printf("%repeat<%log_target=%s><, >%n", %repeat<%log_target><, >);]],
          c_sharp =    [[Console.WriteLine($"%repeat<%log_target: {%log_target}><, >");]],
          odin =       [[fmt.printfln("%repeat<%log_target: %v><, >", %repeat<%log_target><, >)]],
          bash =       [[echo "%repeat<%log_target: ${%log_target}><, >"]],
          swift =      [[print("%repeat<%log_target: %log_target><, >")]],
          kotlin =     [[println("%repeat<%log_target=${%log_target}><, >")]],

          qml =        [[console.log({ %repeat<"%log_target": %log_target><, > })]],
          qmljs =      [[console.log({ %repeat<"%log_target": %log_target><, > })]],
        },
      },
      template_placeholders = {
        tag = function(ctx)
          if vim.g.TIMBER_COLORED_TAG == nil or vim.g.TIMBER_COLORED_TAG > 1000000 then
            vim.g.TIMBER_COLORED_TAG = 0
          end

          vim.g.TIMBER_COLORED_TAG = vim.g.TIMBER_COLORED_TAG + 1

          local color_number = math.fmod(vim.g.TIMBER_COLORED_TAG, #colors)
          local color = colors[color_number]

          vim.cmd("wshada")

          return string.format("N1ZpIq " .. color  .. ": %s", ctx.log_position)
        end,
      },
		})
	end,
}

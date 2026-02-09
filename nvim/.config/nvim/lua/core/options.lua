local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true -- expand tab to spaces
opt.smartindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- Better splitting
opt.splitbelow = true
opt.splitright = true

-- Enable mouse mode
opt.mouse = "a"

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- Set completeopt to have a better completion experience
opt.completeopt = { "menuone", "noselect" }

-- Enable 24-bit color
opt.termguicolors = true

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- turn off swapfile
opt.swapfile = false

-- Always keep 8 lines above/below cursor unless at start/end of file
-- opt.scrolloff = 8 NOTE: disaled since I'm using stay-centered plugin

opt.cursorline = true

opt.shortmess:append({ I = true })

opt.pumheight = 10

opt.showmode = false

-- global statusline
opt.laststatus = 3

local ru_upper = "ЦКЛБЙЗВНТДХПРМГЪЫЯЭФИАОЕСЁЬУЮШ"
local en_upper = 'QWFPBARSTGZXCDVJLUY\\"MNEIOKH<>?'
local ru_lower = "цклбйзвнтдхпрмгъыяэфиаоесёьуюш"
local en_lower = "qwfpbarstgzxcdvjluy'mneiokh\\,./"
opt.langmap = ru_upper .. ";" .. en_upper .. "," .. ru_lower .. ";" .. en_lower

opt.exrc = true

local version = vim.version()

if version.major == 0 and version.minor >= 12 then
  opt.scrollback = 1000000
else
  opt.scrollback = 100000
end

import platform

config.load_autoconfig()

c.url.start_pages = ['https://www.google.com/']
c.url.default_page = 'https://www.google.com/'
c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?hl=en&q={}',
}

config.bind("<Home>", "rl-beginning-of-line", mode="command")
config.bind("<End>", "rl-end-of-line", mode="command")

config.bind('<Ctrl-L>', 'search', mode='normal')

c.colors.webpage.darkmode.enabled = True
c.content.javascript.clipboard = "access"

if platform.system() == 'Darwin':
    config.bind("<Ctrl-V>", "insert-text -- {clipboard}", mode="insert")
    config.bind("<Ctrl-Shift-V>", "insert-text -- {clipboard}", mode="insert")
    config.bind("<Ctrl-V>", "cmd-set-text -a {clipboard}", mode="command")
    config.bind("<Ctrl-Shift-V>", "cmd-set-text -a {clipboard}", mode="command")
    config.bind("<Ctrl-W>", "fake-key <Alt-backspace>", mode="insert")
    config.bind("<Ctrl-Left>", "fake-key <Alt-Left>", mode="insert")
    config.bind("<Ctrl-Right>", "fake-key <Alt-Right>", mode="insert") 
else:
    config.bind("<Ctrl-W>", "fake-key <Ctrl-backspace>", mode="insert")

config.bind("<Ctrl-H>", "fake-key <backspace>", mode="insert")
config.bind("<Ctrl-P>", "fake-key <Up>", mode="insert")
config.bind("<Ctrl-N>", "fake-key <Down>", mode="insert")
config.bind("<Ctrl-J>", "fake-key <enter>", mode="insert")
config.bind("<Ctrl-B>", "fake-key <Left>", mode="insert")
config.bind("<Ctrl-F>", "fake-key <Right>", mode="insert")
config.bind("<Ctrl-D>", "fake-key <Delete>", mode="insert")
config.bind("<Ctrl-E>", "fake-key <End>", mode="insert")
config.bind("<Ctrl-U>", "fake-key <Shift-Home>;; cmd-later 3 fake-key <Delete>", mode="insert")
config.bind("<Ctrl-K>", "fake-key <Shift-End><Delete>", mode="insert")
config.bind("<Ctrl-A>", "fake-key <Home>", mode="insert")

config.bind("<Down>", "fake-key <j>", mode="normal")
config.bind("<Up>", "fake-key <k>", mode="normal")

config.bind("<Shift-Left>", "tab-prev", mode='normal')
config.bind("<Shift-Right>", "tab-next", mode='normal')
config.bind("<Shift-Up>", "tab-prev", mode='normal')
config.bind("<Shift-Down>", "tab-next", mode='normal')

config.bind("<Left>", "scroll left", mode='normal')
config.bind("<Right>", "scroll right", mode='normal')
config.bind("<Up>", "scroll up", mode='normal')
config.bind("<Down>", "scroll down", mode='normal')

c.qt.args = ['ignore-gpu-blocklist', 'enable-gpu-rasterization',
             'enable-accelerated-video-decode', 'enable-quic', 'enable-zero-copy']

config.bind("cp", "tab-only --next", mode="normal")  # close previous
config.bind("cn", "tab-only --prev", mode="normal")  # close next


c.fonts.default_size = "16px"
c.fonts.default_family = "Fira Code"

en_keys = "qwfpbjluy'arstgmneiozxcdvkh,./" + 'QWFPBJLUY"ARSTGMNEIOZXCDVKH<>?'
ru_keys = "цклбйъыяэфзвнтдиаоесхпрмг'ьуюш" + 'ЦКЛБЙЪЫЯЭФЗВНТДИАОЕСХПРМГ"ЬУЮШ'
c.bindings.key_mappings.update(dict(zip(ru_keys, en_keys)))

c.scrolling.smooth = False

c.tabs.position = "left"

c.auto_save.session = True

# Tabs bar colors
c.colors.tabs.bar.bg = "#000000"  # Black background for the tabs bar
c.colors.tabs.even.bg = "#000000"  # Even tabs background
c.colors.tabs.odd.bg = "#000000"   # Odd tabs background
c.colors.tabs.selected.even.bg = "#444444"  # Selected even tab
c.colors.tabs.selected.odd.bg = "#444444"   # Selected odd tab
c.colors.tabs.indicator.start = "#000000"   # Gradient start
c.colors.tabs.indicator.stop = "#000000"    # Gradient end
  
c.scrolling.bar = "always"  # Options: "always", "never", "when-searching"

c.hints.chars = "arstneio"

ru_symbols = "хйцазижфкыеп9ячсвмодгнэъьтушщжлрбю.0"
eng_symbols = "[qwfpb:arstg(zxcdvjluy']mneio;kh,./)"
for ru_symbol, eng_symbol in zip(ru_symbols, eng_symbols):
    c.bindings.key_mappings["<Ctrl-" + ru_symbol + ">"] = "<Ctrl-" + eng_symbol + ">"


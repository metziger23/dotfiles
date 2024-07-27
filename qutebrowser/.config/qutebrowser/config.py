config.load_autoconfig()

c.url.start_pages = ['https://www.google.com/']
c.url.default_page = 'https://www.google.com/'
c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?hl=en&q={}',
}

config.bind("<Ctrl-K>", "completion-item-focus prev", mode="command")
config.bind("<Ctrl-J>", "completion-item-focus next", mode="command")

for i in range (1, 10):
    meta = '<Meta-' + str(i) + '>'
    alt = '<Alt-' + str(i) + '>'
    c.bindings.key_mappings[meta] = alt

config.bind('<Ctrl-L>', 'search', mode='normal')

c.colors.webpage.darkmode.enabled = True
c.content.javascript.clipboard = "access"

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

c.qt.args = ['ignore-gpu-blocklist', 'enable-gpu-rasterization',
             'enable-accelerated-video-decode', 'enable-quic', 'enable-zero-copy']

for mode in ["normal", "insert"]:
    config.bind("<Ctrl-Shift-C>", "fake-key --global <Copy>", mode=mode)
    config.bind("<Ctrl-Shift-V>", "fake-key --global <Paste>", mode=mode)

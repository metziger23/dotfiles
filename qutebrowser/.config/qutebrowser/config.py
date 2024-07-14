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


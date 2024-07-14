config.load_autoconfig()

c.url.start_pages = ['https://www.google.com/']
c.url.default_page = 'https://www.google.com/'
c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?hl=en&q={}',
}

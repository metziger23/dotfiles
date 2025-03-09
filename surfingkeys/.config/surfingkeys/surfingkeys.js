api.mapkey("<Space>", '#1Open a link, press SHIFT to flip overlapped hints, hold SPACE to hide hints', function() {
  api.Hints.create("", api.Hints.dispatchMouseClick);
}, {repeatIgnore: true});

api.mapkey("<Backspace>", '#1Open a link in active new tab', function() {
  api.Hints.create("", api.Hints.dispatchMouseClick, {tabbed: true, active: true});
});

api.map("c<Backspace>", "cf")

api.Hints.setCharacters('tnseriaodhplgmfucbjvkwyxqz');

api.map("<ArrowLeft>",  "h")
api.map("<ArrowDown>",  "j")
api.map("<ArrowUp>",    "k")
api.map("<ArrowRight>", "l")

api.map("<Shift-ArrowLeft>",  "<Ctrl-Shift-Tab>")
api.map("<Shift-ArrowRight>", "<Ctrl-Tab>")

api.vmap("<ArrowLeft>",  "h")
api.vmap("<ArrowDown>",  "j")
api.vmap("<ArrowUp>",    "k")
api.vmap("<ArrowRight>", "l")

api.unmap("h")
api.unmap("j")
api.unmap("k")
api.unmap("l")
api.vunmap("h")
api.vunmap("j")
api.vunmap("k")
api.vunmap("l")

api.map("h", "<Ctrl-j>")

// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;

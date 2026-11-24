> Configure shortcuts in bar

* Toggle vertical tabs expanded
alt+S

* Bookmark this tab ...
control+D => alt+B

* View source
control+U => alt+U

git clone -b langmappings https://github.com/metziger23/vimium

# Installing Vimium from Source

Vimium requires no build step to load from source. It's plain JavaScript, and you load the repo directory directly as an unpacked extension. The `make.js` build tasks are only for producing store packages and running tests.

## Install into Brave

1. **Open** `brave://extensions` in Brave.
2. **Toggle on** "Developer mode" (top-right).
3. Click **"Load unpacked"**.
4. **Select** your cloned directory: `/home/mikhail/tools/vimium`

That's it — Brave will load the extension directly from the source tree. Any time you edit the source files, go back to `brave://extensions` and click the reload arrow on the Vimium card to pick up changes.

## Notes

- **No build is needed for local use.** The `manifest.json` at the repo root is the Chrome/Brave manifest and is ready as-is. You only need the `./make.js write-firefox-manifest` task if you were using Firefox.
- **`./make.js package`** produces zip files for the Chrome/Firefox stores under `dist/`. You don't need this for loading into Brave.
- If you also want to run the tests, you'd need [Deno](https://deno.land/) 2.9+ installed, then:
  - `deno run -A puppeteer browsers install chrome`
  - `./make.js test` (unit + DOM tests)
  - `./make.js test-e2e` (end-to-end tests)

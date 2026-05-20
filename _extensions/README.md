# Quarto Extensions

Vendored Quarto extensions for the workshop slide decks.

## Structure

| Path | Purpose | Upstream |
|---|---|---|
| `esqLABS/esqlabs/` | esqLABS revealjs format (`esqlabs-revealjs`). Sets theme, header logo, footer, code/figure defaults. | in-house |
| `esqLABS/esqlabs/_extensions/shafayetShafee/reveal-header/` | Lua filter that injects the header logo on every slide. Bundled as a dependency of `esqlabs`. | https://github.com/shafayetShafee/reveal-header |
| `quarto-ext/pointer/` | Revealjs laser-pointer plugin. Press `q` during a presentation to toggle a red pointer. | https://github.com/quarto-ext/pointer |

Both third-party extensions are MIT-licensed; see the `LICENSE` file next to each `_extension.yml`.

## Updating

Vendored versions drift silently. To refresh an extension from upstream:

```bash
# from repo root
quarto add quarto-ext/pointer
quarto add shafayetShafee/reveal-header
```

When updating `reveal-header`, copy the refreshed files into `_extensions/esqLABS/esqlabs/_extensions/shafayetShafee/reveal-header/` so it stays bundled with the esqLABS format. Bump `version:` in `_extensions/esqLABS/esqlabs/_extension.yml` when changes are made to the esqLABS template itself.

The in-house `esqLABS/esqlabs/` extension is maintained directly in this repo. There is no upstream to pull from.

## Known limitations

### Google Fonts loaded over the network

`_extensions/esqLABS/esqlabs/esqlabs.scss` imports Comfortaa, Open Sans, and Fira Code via `@import url('https://fonts.googleapis.com/...')`. The fonts are fetched by the browser at render time and again when the slide deck is opened, so:

- Rendering requires internet access; otherwise the browser falls back to the system sans-serif/monospace stacks declared after each `'Family Name', ...` entry.
- `embed-resources: true` does not inline these fonts. To make slide decks fully self-contained, download the woff2 files from `fonts.gstatic.com`, place them under `_extensions/esqLABS/esqlabs/fonts/`, and replace the `@import url(...)` lines in `esqlabs.scss` with `@font-face` blocks pointing to the local files.

The system fallbacks are good enough for offline rendering at workshops where the visual identity is secondary; the upgrade is worth doing if pixel-identical offline rendering becomes a requirement.

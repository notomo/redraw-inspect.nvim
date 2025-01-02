# redraw-inspect.nvim

Inspect neovim window redrawing.

## Example

```lua
require("redraw-inspect").start({
  on_redraw = require("redraw-inspect.util").highlight_line(),
})
```
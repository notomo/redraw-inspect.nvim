local setup_highlight_groups = function()
  local highlightlib = require("redraw-inspect.vendor.misclib.highlight")
  return {
    RedrawInspectRedrawn = highlightlib.link("RedrawInspectRedrawn", "Todo"),
  }
end

local group = vim.api.nvim_create_augroup("redraw-inspect.highlight_group", {})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    setup_highlight_groups()
  end,
})

return setup_highlight_groups()

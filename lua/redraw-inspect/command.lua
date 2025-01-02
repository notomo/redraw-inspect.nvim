local M = {}

function M.start(raw_opts)
  raw_opts = raw_opts or {}
  local window_id = raw_opts.window_id or vim.api.nvim_get_current_win()
  local on_redraw = raw_opts.on_redraw or function(_) end

  require("redraw-inspect.callback").start(window_id, on_redraw)
end

function M.stop(raw_opts)
  raw_opts = raw_opts or {}
  local window_id = raw_opts.window_id or vim.api.nvim_get_current_win()

  require("redraw-inspect.callback").stop(window_id)
end

return M

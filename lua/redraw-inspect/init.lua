local M = {}

--- @class RedrawInspectRedrawContext
--- @field bufnr integer
--- @field window_id integer
--- @field ns_id integer
--- @field row integer 0-based index

--- @class RedrawInspectStartOption
--- @field window_id integer? (default: current window id)
--- @field on_redraw fun(ctx:RedrawInspectRedrawContext)? called on redraw line (default: do nothing)

--- Starts redraw inspect.
--- @param opts RedrawInspectStartOption?
function M.start(opts)
  return require("redraw-inspect.command").start(opts)
end

--- @class RedrawInspectStopOption
--- @field window_id integer? (default: current window id)

--- Stops redraw inspect.
--- @param opts RedrawInspectStopOption?
function M.stop(opts)
  return require("redraw-inspect.command").stop(opts)
end

return M

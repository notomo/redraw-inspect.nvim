local M = {}

--- @class RedrawInspectHighlightLineOption
--- @field hl_group string? (default: RedrawInspectRedrawn)
--- @field timeout_ms integer? (default: 250)
--- @field priority integer? (default: vim.hl.priorities.user)

--- Highlights line on redraw.
--- @param opts RedrawInspectHighlightLineOption?
function M.highlight_line(opts)
  local default_opts = {
    hl_group = require("redraw-inspect.highlight_group").RedrawInspectRedrawn,
    timeout_ms = 250,
    priority = vim.hl.priorities.user,
  }
  opts = vim.tbl_deep_extend("force", default_opts, opts or {})

  local scheduled = {}
  return function(ctx)
    local row = ctx.row
    if scheduled[row] then
      return
    end
    scheduled[row] = true

    vim.api.nvim_buf_set_extmark(ctx.bufnr, ctx.ns, row, 0, {
      end_row = row + 1,
      ephemeral = true,
      hl_group = opts.hl_group,
      priority = opts.priority,
    })

    vim.defer_fn(function()
      if not vim.api.nvim_win_is_valid(ctx.window_id) then
        return
      end
      vim.api.nvim__redraw({ win = ctx.window_id, range = { row, row + 1 }, valid = true })
      scheduled[row] = nil
    end, opts.timeout_ms)
  end
end

return M

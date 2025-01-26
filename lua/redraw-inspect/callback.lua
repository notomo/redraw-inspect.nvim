local vim = vim

local ns = vim.api.nvim_create_namespace("redraw-inspect")

local callbacks = {}
vim.api.nvim_set_decoration_provider(ns, {})
vim.api.nvim_set_decoration_provider(ns, {
  on_win = function(_, window_id)
    return callbacks[window_id] ~= nil
  end,
  on_line = function(_, window_id, bufnr, row)
    local ctx = {
      ns = ns,
      window_id = window_id,
      bufnr = bufnr,
      row = row,
    }
    callbacks[window_id](ctx)
  end,
})

local M = {}

local group_name = function(window_id)
  return ("redraw-inspect.window_%s"):format(window_id)
end

function M.start(window_id, on_redraw)
  local group = vim.api.nvim_create_augroup(group_name(window_id), {})
  vim.api.nvim_create_autocmd({ "WinClosed" }, {
    group = group,
    pattern = { "*" },
    callback = function(args)
      if tonumber(args.file) ~= window_id then
        return
      end
      M.stop(window_id)
      return true
    end,
  })

  callbacks[window_id] = on_redraw
end

function M.stop(window_id)
  vim.api.nvim_clear_autocmds({ group = group_name(window_id) })
  callbacks[window_id] = nil
end

return M

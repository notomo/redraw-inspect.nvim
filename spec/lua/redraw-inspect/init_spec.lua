local helper = require("redraw-inspect.test.helper")
local redrawinspect = helper.require("redraw-inspect")
local assert = require("assertlib").typed(assert)

describe("redraw-inspect.start()", function()
  before_each(helper.before_each)
  after_each(helper.after_each)

  it("starts on_redraw callback", function()
    local called = {}
    redrawinspect.start({
      on_redraw = function(ctx)
        called = ctx
      end,
    })
    vim.cmd.redraw()

    assert.same(vim.api.nvim_get_current_win(), called.window_id)
    assert.same(vim.api.nvim_get_current_buf(), called.bufnr)
  end)

  it("does not cause error with highlight_line util", function()
    redrawinspect.start({
      on_redraw = require("redraw-inspect.util").highlight_line(),
    })
    vim.cmd.redraw()
  end)
end)

describe("redraw-inspect.stop()", function()
  before_each(helper.before_each)
  after_each(helper.after_each)

  it("stops on_redraw callback", function()
    local called = false
    redrawinspect.start({
      on_redraw = function(_)
        called = true
      end,
    })
    redrawinspect.stop()
    vim.cmd.redraw()

    assert.is_false(called)
  end)
end)

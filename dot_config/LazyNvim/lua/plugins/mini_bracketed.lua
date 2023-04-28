return {
  'echasnovski/mini.bracketed',
  -- enabled = false,
  event = 'CursorHold',
  config = function()
    require('mini.bracketed').setup({
      comment = { suffix = 'g', options = {} },
    })
  end,
}

return {
  'kylechui/nvim-surround',
  -- event = 'VeryLazy',
  event = 'CursorHold',
  config = function()
    require('nvim-surround').setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}

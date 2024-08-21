return {
  'echasnovski/mini.files',
  keys = { { '<F1>', '<cmd>lua MiniFiles.open()<CR>' } },
  config = function()
    require('mini.files').setup()
  end,
}

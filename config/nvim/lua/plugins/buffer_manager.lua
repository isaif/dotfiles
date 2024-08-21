return {
  'j-morano/buffer_manager.nvim',
  event = 'BufWinEnter',
  keys = {
    {
      '<leader>b',
      '<cmd>lua require("buffer_manager.ui").toggle_quick_menu()<CR>',
    },
  },
  opts = {
    line_keys = '1234567890',
    select_menu_item_commands = {
      edit = { key = '<CR>', command = 'edit' },
      v = { key = '<C-v>', command = 'vsplit' },
      h = { key = '<C-h>', command = 'split' },
    },
  },
  config = function()
    local opts = { noremap = true }
    local map = vim.keymap.set
    -- Navigate buffers bypassing the menu
    local bmui = require('buffer_manager.ui')
    local keys = '1234567890'
    for i = 1, #keys do
      local key = keys:sub(i, i)
      map('n', string.format('<leader>%s', key), function()
        bmui.nav_file(i)
      end, opts)
    end
  end,
}

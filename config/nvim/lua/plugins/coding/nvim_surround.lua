return {
  'kylechui/nvim-surround',
  -- event = 'VeryLazy',
  -- event = 'CursorHold',
  opts = {
    keymaps = {
      insert = false,
      insert_line = false,
      normal = false,
      normal_cur = false,
      normal_line = false,
      normal_cur_line = false,
      visual = false,
      visual_line = false,
      delete = false,
      change = false,
      change_line = false,
    },
    move_cursor = 'sticky',
    aliases = {
      -- ['a'] = '>',
      -- making 'b' similar to mini.ai
      ['b'] = { ')', '}', ']', '>' },
      -- 'B' is provided by vim/neovim
      -- ['B'] = '}',
      -- ['r'] = ']',
      ['q'] = { '"', "'", '`' },
      ['s'] = { '}', ']', ')', '>', '"', "'", '`' },
    },
  },
  keys = {
    { ',s', '<Plug>(nvim-surround-normal)' },
    -- { 'ySS', '<Plug>(nvim-surround-normal-cur)' },
    { ',s', '<Plug>(nvim-surround-visual)', mode = 'v' },
    { ',c', '<Plug>(nvim-surround-change)' },
    { ',d', '<Plug>(nvim-surround-delete)' },
    { ')', '<Plug>(nvim-surround-visual))', mode = 'v' },
    { '}', '<Plug>(nvim-surround-visual)}', mode = 'v' },
    -- FIX: single ] not working, need to press ] twice
    { ']', '<Plug>(nvim-surround-visual)]', mode = 'v' },
    { '`', '<Plug>(nvim-surround-visual)`', mode = 'v' },
    { '"', '<Plug>(nvim-surround-visual)"', mode = 'v' },
    { "'", "<Plug>(nvim-surround-visual)'", mode = 'v' },
  },
}

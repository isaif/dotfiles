return {
  'gbprod/yanky.nvim',
  opts = {
    textobj = {
      enabled = true,
    },
  },
  keys = {
    {
      '<leader>y',
      function()
        require('telescope').extensions.yank_history.yank_history({})
      end,
      desc = 'Open Yank History',
    },
    { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
    {
      'p',
      '<Plug>(YankyPutAfter)',
      mode = { 'n', 'x' },
      desc = 'Put yanked text after cursor',
    },
    {
      'P',
      '<Plug>(YankyPutBefore)',
      mode = { 'n', 'x' },
      desc = 'Put yanked text before cursor',
    },
    {
      'gp',
      '<Plug>(YankyGPutAfter)',
      mode = { 'n', 'x' },
      desc = 'Put yanked text after selection',
    },
    {
      'gP',
      '<Plug>(YankyGPutBefore)',
      mode = { 'n', 'x' },
      desc = 'Put yanked text before selection',
    },
    {
      '<c-p>',
      '<Plug>(YankyPreviousEntry)',
      desc = 'Select previous entry through yank history',
    },
    {
      '<c-n>',
      '<Plug>(YankyNextEntry)',
      desc = 'Select next entry through yank history',
    },
    {
      ']p',
      '<Plug>(YankyPutIndentAfterLinewise)',
      desc = 'Put indented after cursor (linewise)',
    },
    {
      '[p',
      '<Plug>(YankyPutIndentBeforeLinewise)',
      desc = 'Put indented before cursor (linewise)',
    },
    {
      ']P',
      '<Plug>(YankyPutIndentAfterLinewise)',
      desc = 'Put indented after cursor (linewise)',
    },
    {
      '[P',
      '<Plug>(YankyPutIndentBeforeLinewise)',
      desc = 'Put indented before cursor (linewise)',
    },
    {
      '>p',
      '<Plug>(YankyPutIndentAfterShiftRight)',
      desc = 'Put and indent right',
    },
    {
      '<p',
      '<Plug>(YankyPutIndentAfterShiftLeft)',
      desc = 'Put and indent left',
    },
    {
      '>P',
      '<Plug>(YankyPutIndentBeforeShiftRight)',
      desc = 'Put before and indent right',
    },
    {
      '<P',
      '<Plug>(YankyPutIndentBeforeShiftLeft)',
      desc = 'Put before and indent left',
    },
    {
      '=p',
      '<Plug>(YankyPutAfterFilter)',
      desc = 'Put after applying a filter',
    },
    {
      '=P',
      '<Plug>(YankyPutBeforeFilter)',
      desc = 'Put before applying a filter',
    },
    -- {
    --   'lp', -- slows down l key i.e. move left
    --   function()
    --     require('yanky.textobj').last_put()
    --   end,
    --   { 'o', 'x' },
    --   desc = 'also can be used to select last put using lp',
    -- },
  },
}

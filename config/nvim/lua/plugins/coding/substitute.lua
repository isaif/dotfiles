return {
  'gbprod/substitute.nvim',
  opts = {},
  keys = {
    {
      'gs',
      function()
        require('substitute').operator()
      end,
    },
    {
      'gs',
      function()
        require('substitute').visual()
      end,
      mode = 'x',
    },
    -- { 'n', 'ss', require('substitute').line, { noremap = true } },
    -- { 'n', 'S', require('substitute').eol, { noremap = true } },
  },
}

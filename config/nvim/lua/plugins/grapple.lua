return {
  'cbochs/grapple.nvim',
  opts = {
    scope = 'git_branch',
  },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
    {
      '<leader>M',
      '<cmd>Grapple toggle_tags<cr>',
      desc = 'Grapple open tags window',
    },
    {
      '<leader>n',
      '<cmd>Grapple cycle_tags next<cr>',
      desc = 'Grapple cycle next tag',
    },
    {
      '<leader>p',
      '<cmd>Grapple cycle_tags prev<cr>',
      desc = 'Grapple cycle previous tag',
    },

    {
      '<leader>d',
      '<cmd>Grapple select index=1<cr>',
      desc = 'Select first tag',
    },
    {
      '<leader>f',
      '<cmd>Grapple select index=2<cr>',
      desc = 'Select second tag',
    },
    {
      '<leader>j',
      '<cmd>Grapple select index=3<cr>',
      desc = 'Select third tag',
    },
    {
      '<leader>k',
      '<cmd>Grapple select index=4<cr>',
      desc = 'Select fourth tag',
    },
  },
}
-- return {
--   'cbochs/portal.nvim',
--   -- Optional dependencies
--   dependencies = {
--     { 'cbochs/grapple.nvim' },
--     -- "ThePrimeagen/harpoon"
--   },
-- }

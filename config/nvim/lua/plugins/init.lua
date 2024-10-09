-- plugins which don't require extra setup

return {
  -- better tmux experience
  { 'christoomey/vim-tmux-navigator', event = 'CursorHold' },

  --  use Meta hjkl to resize panes
  { 'RyanMillerC/better-vim-tmux-resizer', event = 'CursorHold' },

  -- merge tmux statusbar and vim/neovim statusline
  'vimpostor/vim-tpipeline',

  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  {
    'LintaoAmons/scratch.nvim',
    event = 'VeryLazy',
    version = 'v0.13.2',
  },
  { 'sindrets/diffview.nvim' },
}

-- plugins which don't require extra setup

return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  -- better tmux experience
  { 'christoomey/vim-tmux-navigator', event = 'CursorHold' },
  { 'RyanMillerC/better-vim-tmux-resizer', event = 'CursorHold' },

  -- merge tmux statusbar and vim/neovim statusline
  -- 'vimpostor/vim-tpipeline',

  -- provides highlights for kmonad configuration file
  { 'kmonad/kmonad-vim', ft = 'kbd' },
}

-- plugins which don't require extra setup

return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  -- better tmux experience
  'christoomey/vim-tmux-navigator',
  'RyanMillerC/better-vim-tmux-resizer',

  -- merge tmux statusbar and vim/neovim statusline
  -- 'vimpostor/vim-tpipeline',

  -- provides highlights for kmonad configuration file
  { 'kmonad/kmonad-vim', ft = 'kbd' },
}

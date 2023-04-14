-- plugins which don't require extra setup

return {
  'neovim/nvim-lspconfig',
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  'ThePrimeagen/harpoon',
  'RyanMillerC/better-vim-tmux-resizer',
  -- merge tmux statusbar and vim/neovim statusline
  -- 'vimpostor/vim-tpipeline',
  'christoomey/vim-tmux-navigator',
  -- provides highlights for kmonad configuration file
  { 'kmonad/kmonad-vim', ft = 'kbd' },
}

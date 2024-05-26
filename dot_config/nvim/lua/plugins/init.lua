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
  'vimpostor/vim-tpipeline',

  -- provides highlights for kmonad configuration file
  { 'kmonad/kmonad-vim', ft = 'kbd' },
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  {
    'declancm/maximize.nvim',
    keys = {
      {
        '<leader>z',
        function()
          require('maximize').toggle()
        end,
      },
    },
    config = function()
      require('maximize').setup()
    end,
  },
}

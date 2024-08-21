-- plugins which don't require extra setup

return {
  -- better tmux experience
  { 'christoomey/vim-tmux-navigator', event = 'CursorHold' },

  --  use Meta hjkl to resize panes
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
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup({
        render = 'virtual',
        virtual_symbol = '■',
      })
    end,
  },
  {
    'tversteeg/registers.nvim',
    cmd = 'Registers',
    config = true,
    keys = {
      { '"', mode = { 'n', 'v' } },
      { '<C-R>', mode = 'i' },
    },
    name = 'registers',
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
  {
    'folke/twilight.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    'LintaoAmons/scratch.nvim',
    event = 'VeryLazy',
    version = 'v0.13.2',
  },
  -- TODO: fuzzy search path in command line
  { 'Darazaki/indent-o-matic' },
  { 'sindrets/diffview.nvim' },
}

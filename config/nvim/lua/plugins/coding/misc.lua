return {
  -- Dumb automatic fast indentation detection for Neovim written in Lua
  { 'Darazaki/indent-o-matic' },

  -- plugin that dims inactive portions of the code you’re editing.
  {
    'folke/twilight.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
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

  -- provides highlights for kmonad configuration file
  { 'kmonad/kmonad-vim', ft = 'kbd' },
}

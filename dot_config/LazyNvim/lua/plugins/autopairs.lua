return {
  -- auto pairing of brackets etc
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = { check_ts = true },
  },

  -- auto close and auto rename html tags using treesitter
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        autotag = {
          enable = true,
        },
      })
    end,
  },
}

return {
  -- auto pairing of brackets etc
  {
    'windwp/nvim-autopairs',
    opts = { check_ts = true },
  },

  -- auto close and auto rename html tags using treesitter
  {
    'windwp/nvim-ts-autotag',
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

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
    opts = {
      -- Defaults
      -- enable_close = true, -- Auto close tags
      -- enable_rename = true, -- Auto rename pairs of tags
      -- enable_close_on_slash = false, -- Auto close on trailing </
    },
  },
}

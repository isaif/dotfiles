return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  ---disable it for f/F/t/T and /? search
  opts = {
    modes = { search = { enabled = false }, char = { enabled = false } },

    label = {
      rainbow = {
        enabled = true,
        -- number between 1 and 9
        shade = 5,
      },
    },
  },
  -- stylua: ignore
    keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}

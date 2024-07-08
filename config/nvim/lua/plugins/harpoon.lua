local keys = {

  { ',ga', '<cmd>lua require("harpoon.mark").set_current_at(1)<CR>' },
  { ',gs', '<cmd>lua require("harpoon.mark").set_current_at(2)<CR>' },
  { ',gd', '<cmd>lua require("harpoon.mark").set_current_at(3)<CR>' },
  { ',gf', '<cmd>lua require("harpoon.mark").set_current_at(4)<CR>' },
  {
    ',gg',
    '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
    { silent = false },
  },

  { ',a', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>' },
  { ',s', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>' },
  { ',d', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>' },
  { ',f', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>' },

  -- open in a vertical split
  { ',va', '<cmd>vs<CR><cmd>lua require("harpoon.ui").nav_file(1)<CR>' },
  { ',vs', '<cmd>vs<CR><cmd>lua require("harpoon.ui").nav_file(2)<CR>' },
  { ',vd', '<cmd>vs<CR><cmd>lua require("harpoon.ui").nav_file(3)<CR>' },
  { ',vf', '<cmd>vs<CR><cmd>lua require("harpoon.ui").nav_file(4)<CR>' },

  -- open in a new tab
  { ',ta', '<cmd>tabe<CR><cmd>lua require("harpoon.ui").nav_file(1)<CR>' },
  { ',ts', '<cmd>tabe<CR><cmd>lua require("harpoon.ui").nav_file(2)<CR>' },
  { ',td', '<cmd>tabe<CR><cmd>lua require("harpoon.ui").nav_file(3)<CR>' },
  { ',tf', '<cmd>tabe<CR><cmd>lua require("harpoon.ui").nav_file(4)<CR>' },
}
return {
  'ThePrimeagen/harpoon',
  -- event = 'CursorHold',
  keys = keys,
  dependencies = { 'nvim-lua/plenary.nvim' },
}

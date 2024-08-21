local function navigate(num)
  vim.fn.cursor(num, 0)

  -- Simulate pressing the Enter key
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes('<CR>', true, false, true),
    'm',
    false
  )
end

return {
  'dzfrias/arena.nvim',
  event = 'BufWinEnter',
  -- keys = { { '<leader>b', '<cmd>ArenaToggle<CR>' } },
  -- Calls `.setup()` automatically
  opts = {
    buf_opts = {
      ['relativenumber'] = false,
    },
    -- In setup options
    keybinds = {
      ['1'] = function()
        navigate(1)
      end,
      ['2'] = function()
        navigate(2)
      end,
      ['3'] = function()
        navigate(3)
      end,
      ['4'] = function()
        navigate(4)
      end,
      ['5'] = function()
        navigate(5)
      end,
    },
  },
}

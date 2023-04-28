-- Bidirectional search in the current window is just a specific case of the
-- multi-window mode - set `target-windows` to a table containing the current
-- window as the only element:
local function leap_bidirectional()
  require('leap').leap({ target_windows = { vim.fn.win_getid() } })
end

-- Map them to your preferred key, like:
-- vim.keymap.set('n', '<leader>k', leap_bidirectional, { silent = true })
vim.keymap.set('n', 's', leap_bidirectional, { silent = true })

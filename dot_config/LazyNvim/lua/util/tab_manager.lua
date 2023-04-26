local M = {}

M.find_tab = function(desired_filetype)
  -- Loop through all tabpages
  for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    -- Loop through all windows in the current tabpage
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
      -- Get the buffer associated with the current window
      local bufnr = vim.api.nvim_win_get_buf(win)

      -- Get the filetype option value of the buffer
      local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')

      -- Check if the buffer's filetype matches the desired filetype
      if filetype == desired_filetype then
        return tabpage, win, bufnr
      end
    end
  end

  return nil
end

return M

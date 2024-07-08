local close_fugitive = function()
  local tabpage, _, _ = require('util.tab_manager').find_tab('fugitive')
  if tabpage then
    vim.api.nvim_command(tabpage .. 'tabclose')
  end
end

return {
  'rmagatti/auto-session',
  -- enabled = false,
  opts = {
    -- won't create session in these directories but will in its subdirectories
    auto_session_suppress_dirs = { '~/', '~/my-projects', '~/experiments' },

    -- fugitive is lazy loading so any tab with fugitive should be closed
    -- else keymaps for fugitive doesn't work unless that window is closed
    post_restore_cmds = {close_fugitive}
  },
}

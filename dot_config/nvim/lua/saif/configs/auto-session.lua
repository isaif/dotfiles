local opts = {
  log_level = 'info',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/',
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  -- won't create session in these directories but will in its subdirectories
  auto_session_suppress_dirs = { '~/', '~/my-projects', '~/experiments' },
}

require('auto-session').setup(opts)

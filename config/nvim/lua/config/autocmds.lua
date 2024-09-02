local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

-- -- Configure neovim to run chezmoi apply whenever a dotfile is saved
-- -- while inside the source directory
-- vim.api.nvim_create_autocmd('BufWritePost', {
--   group = augroup('chezmoi'),
--   pattern = vim.fn.expand('~') .. '/.local/share/chezmoi/*',
--   callback = function()
--     -- vim.cmd([[!notify-send "% successfully written"]])
--     vim.cmd([[!chezmoi apply --source-path %]])
--   end,
-- })

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    -- vim.highlight.on_yank({ on_visual = false })
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
-- vim.api.nvim_create_autocmd({ 'VimResized' }, {
--   group = augroup('resize_splits'),
--   callback = function()
--     vim.cmd('tabdo wincmd =')
--   end,
-- })

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'vim', -- command-line-window i.e. ':q' filetype window
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set(
      'n',
      'q',
      '<cmd>close<cr>',
      { buffer = event.buf, silent = true }
    )
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('wrap_spell'),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Having issue using this with fugitive
-- Also don't want to automatically create directory
-- other options exist to enable it for a particular file
-- using `:w ++p`
-- Auto create dir when saving a file, in case some intermediate directory does not exist
-- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
--   group = augroup('auto_create_dir'),
--   callback = function(event)
--     local file = vim.loop.fs_realpath(event.match) or event.match
--     vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
--   end,
-- })

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, 'auto-cursorline')
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, 'auto-cursorline')
    end
  end,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, 'auto-cursorline', cl)
      vim.wo.cursorline = false
    end
  end,
})

-- -- Fix conceallevel for json & help files
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   pattern = { 'json', 'jsonc' },
--   callback = function()
--     vim.wo.spell = false
--     vim.wo.conceallevel = 0
--   end,
-- })

vim.api.nvim_create_augroup('_editing', { clear = true })

-- -- Enable spell check and word wrap for certain file types
-- vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
--   group = '_editing',
--   pattern = { '*.txt', '*.md', '*.tex' },
--   callback = function()
--     vim.cmd('setlocal spell')
--     vim.cmd('setlocal wrap')
--   end,
-- })

-- Prevent IndentLine from hiding ``` in markdown files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = '_editing',
  pattern = { '*.md', '*.markdown' },
  callback = function()
    vim.g['indentLine_enabled'] = 0
    vim.g['markdown_syntax_conceal'] = 0
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = '_editing',
  pattern = 'markdown',
  callback = function()
    vim.g['indentLine_enabled'] = 0
    vim.g['markdown_syntax_conceal'] = 0
  end,
})

-- vim.api.nvim_create_augroup("_skhd", { clear = true })

-- -- Set Active Admin .arb files to be ruby files
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   group = "_skhd",
--   pattern = "skhdrc",
--   callback = function() vim.cmd("setfiletype bash") end,
-- })

local M = {}

-- vim.keymap.set has remap = false by default
-- mappings with <cmd> is silent by default
-- <cmd> doesn't need <C-u> as it doesn't change mode
M.noremap = function(mode, lhs, rhs, opts)
  local default_opts = { silent = true }

  -- if opts then
  --   for k, v in pairs(opts) do
  --     default_opts[k] = v
  --   end
  -- end

  if opts then
    default_opts = vim.tbl_extend('force', default_opts, opts)
  end
  -- if rhs == '<leader>ff' then
  -- if rhs == ',ld' or '<leader>ff' then
  -- print(rhs)
  -- print(vim.inspect(default_opts))
  -- print(vim.inspect(opts))
  -- print('-------')
  -- end

  vim.keymap.set(mode, lhs, rhs, default_opts)
end

M.nnoremap = function(lhs, rhs, opts)
  -- print(rhs)
  -- print(vim.inspect(opts))
  opts = opts or {}
  -- print(vim.inspect(opts))
  -- print('-------')
  M.noremap('n', lhs, rhs)
end

M.inoremap = function(lhs, rhs, opts)
  opts = opts or {}
  M.noremap('i', lhs, rhs)
end

M.xnoremap = function(lhs, rhs, opts)
  opts = opts or {}
  M.noremap('x', lhs, rhs)
end

M.onoremap = function(lhs, rhs, opts)
  opts = opts or {}
  M.noremap('o', lhs, rhs)
end

M.vnoremap = function(lhs, rhs, opts)
  opts = opts or {}
  M.noremap('v', lhs, rhs)
end

M.tnoremap = function(lhs, rhs, opts)
  opts = opts or {}
  M.noremap('t', lhs, rhs)
end

return M

local mapping = {}

local noremap = { noremap = true, silent = true }

local map = function(mode, rhs, lhs, opts)
  vim.api.nvim_set_keymap(mode, rhs, lhs, opts)
end

local nmap = function(...)
  map('n', ...)
end

function mapping.nnoremap(lsh, rhs)
  nmap(lsh, rhs, noremap)
end

return mapping

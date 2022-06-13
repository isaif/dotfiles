local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    -- filter = function(clients)
    --   return vim.tbl_filter(function(client)
    --     return client.name == 'null-ls'
    --   end, clients)
    -- end,
    bufnr = bufnr,
    name = 'null-ls',
  })
end

-- functions for mappings
local vimp = require('vimp')

local function nnoremap(...)
  vimp.nnoremap({ 'silent' }, ...)
end

-- To add mappings to current buffer only
local bufmap = vimp.add_buffer_maps

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  bufmap(bufnr, function()
    -- nnoremap({'silent'}, 'gd', ':Telescope lsp_definitions<cr>')
    nnoremap(',ld', ':Telescope lsp_document_symbols<CR>')
    nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    nnoremap('gd', ':Telescope lsp_definitions<cr>')
    nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    nnoremap('gr', ':Telescope lsp_refrences<CR>')
    nnoremap(',lt', ':Telescope lsp_type_definitions<CR>')
    nnoremap(',lr', '<cmd>lua vim.lsp.buf.rename()<CR>')
    nnoremap(',li', ':Telescope lsp_implementations<CR>')
    nnoremap(',ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    -- nnoremap(',lc', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    nnoremap(',lc', ':Telescope lsp_code_actions<CR>')
    nnoremap(',lm', '<cmd>lua vim.diagnostic.open_float()<CR>')
    nnoremap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    nnoremap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  end)

  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
        -- vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'sumneko_lua', 'tsserver', 'null-ls' }
for _, server in pairs(servers) do
  require('saif.lsp.' .. server).setup(on_attach, capabilities)
end

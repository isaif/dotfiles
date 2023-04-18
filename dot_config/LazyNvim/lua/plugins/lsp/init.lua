local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- return vim.tbl_filter(function(client)
      --   return client.name == 'null-ls'
      -- end, clients)

      -- don't use null-ls for formatting prisma files
      if client.name == 'prismals' then
        return client.name == 'prismals'
      else
        return client.name == 'null-ls'
      end
    end,
    bufnr = bufnr,
    -- name = 'null-ls',
  })
end

return {
  -- use official lspconfig package (and enable completion):
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    {
      'jose-elias-alvarez/null-ls.nvim',
      event = { 'BufReadPre', 'BufNewFile' },
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  config = function()
    -- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
    lsp_capabilities =
      require('cmp_nvim_lsp').default_capabilities(capabilities)

    local lsp_on_attach = function(client, bufnr)
      local bufmap = function(lhs, rhs)
        vim.keymap.set('n', lhs, rhs, { buffer = bufnr, silent = true })
      end

      bufmap(',ld', '<cmd>Telescope lsp_document_symbols<CR>')
      bufmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
      bufmap('gd', '<cmd>Telescope lsp_definitions<cr>')
      bufmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
      bufmap('gr', '<cmd>Telescope lsp_references<CR>')
      bufmap(',lt', '<cmd>Telescope lsp_type_definitions<CR>')
      bufmap(',lr', '<cmd>lua vim.lsp.buf.rename()<CR>')
      bufmap(',li', '<cmd>Telescope lsp_implementations<CR>')
      bufmap(',ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
      bufmap(',la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      bufmap(',lm', '<cmd>lua vim.diagnostic.open_float()<CR>')
      bufmap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
      bufmap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')

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

    local servers = require('plugins.lsp.servers')
    for _, server in pairs(servers) do
      require('plugins.lsp.servers.' .. server).setup(
        lsp_on_attach,
        lsp_capabilities
      )
    end
  end,

  -- ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
}

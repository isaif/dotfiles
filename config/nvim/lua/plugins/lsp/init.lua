return {
  -- use official lspconfig package (and enable completion):
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',

    -- Automatically configures lua-language-server
    -- for your Neovim config, Neovim runtime and plugin directories
    'folke/neodev.nvim',

    -- Neovim plugin to manage global and project-local settings.
    'folke/neoconf.nvim',
  },
  config = function()
    require('neoconf').setup({
      -- override any of the default settings here
    })

    require('neodev').setup({
      -- override = function(root_dir, library)
      --   -- if require("neodev.util").has_file(root_dir, "/etc/nixos") then
      --   --   library.enabled = true
      --   --   library.plugins = true
      --   -- end
      -- end,
    })

    -- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
    lsp_capabilities =
      require('cmp_nvim_lsp').default_capabilities(lsp_capabilities)

    local lsp_on_attach = function(client, bufnr)
      local bufmap = function(lhs, rhs)
        vim.keymap.set('n', lhs, rhs, { buffer = bufnr, silent = true })
      end

      -- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
      -- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
      -- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
      -- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|

      bufmap('grs', '<cmd>Telescope lsp_document_symbols<CR>')
      -- 'K' mapping moved to nvim-ufo plugin mapping
      -- bufmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
      bufmap('gd', '<cmd>Telescope lsp_definitions<cr>')
      bufmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
      -- bufmap('gr', '<cmd>Telescope lsp_references<CR>')
      bufmap('grt', '<cmd>Telescope lsp_type_definitions<CR>')
      -- bufmap(',lr', '<cmd>lua vim.lsp.buf.rename()<CR>')
      bufmap('gri', '<cmd>Telescope lsp_implementations<CR>')
      -- bufmap(',ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
      -- bufmap(',la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      bufmap('grd', '<cmd>lua vim.diagnostic.open_float()<CR>')
      -- This mapping is provided by mini.bracketed plugin
      -- bufmap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
      -- bufmap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
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
